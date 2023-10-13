class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!


  def after_sign_in_path_for(resource)
    user_path(resource)
  end
end
