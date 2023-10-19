class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :destroy, :edit, :update, :resend_confirmation_instructions, :resend_invitation]
  before_action :require_admin, only: [:edit, :update, :ban, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def edit

  end

  def update
    @user.update(user_params)
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "User with email #{@user.email} successfully destroyed"
  end


  def ban
    @user = User.find(params[:id])
    notice = ""
    if @user.access_locked?
      notice = "User unbanned!"
      @user.unlock_access!
    else
      notice = "User banned!"
      @user.lock_access!
    end
    redirect_to @user, notice: notice
  end

  def resend_confirmation_instructions
    if @user.resend_confirmation_instructions
      redirect_to @user, notice: "Confirmation instructions has been sent"
    else
      redirect_to @user, alert: "User already has been confirmed"
    end
  end

  def resend_invitation
    if @user.created_by_invite? && !@user.invitation_accepted? && !@user.confirmed?
      @user.invite!
      redirect_to @user, notice: "Invitation has been sent"
    else
      redirect_to @user, alert: "User already has been confirmed"
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(*User::ROLES) # The * (splat) operator is used to convert the elements of the User::ROLES array into individual arguments when passing them to the permit method. This is a common Ruby programming feature that is often used with methods that accept a variable number of arguments.
  end

  private
  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized!"
    end
  end


end
