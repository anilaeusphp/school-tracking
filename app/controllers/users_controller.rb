class UsersController < ApplicationController

  before_action :set_user, only: [:show, :destroy]
  def index
    @users = User.all
  end

  def show
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

  private
  def set_user
    @user = User.find(params[:id])
  end
end
