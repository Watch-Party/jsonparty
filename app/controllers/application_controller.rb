class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_filter :configure_permitted_parameters, if: :devise_controller?

  # before_action :set_format
  # before_action :authenticate_user!

  def set_format
    request.format = :json
  end

  protected

   def configure_permitted_parameters
       devise_parameter_sanitizer.permit(:sign_up, keys: [:screen_name, :email, :password, :first_name, :last_name])
       devise_parameter_sanitizer.permit(:account_update, keys: [:screen_name, :remote_avatar_url, :email, :password, :current_password, :avatar, :bio, :location, :first_name, :last_name])
   end
end
