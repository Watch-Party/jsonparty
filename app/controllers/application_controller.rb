class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  before_action :set_format

  def set_format
    request.format = :json

  end

  protected

   def configure_permitted_parameters
       devise_parameter_sanitizer.permit(:sign_up, keys: [:screen_name, :email, :password, :first_name, :last_name])
       devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:screen_name, :email, :password, :current_password, :avatar_url, :bio, :location, :first_name, :last_name) }
   end
end
