class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

   def configure_permitted_parameters
       devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:screen_name, :email, :password) }
       devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:screen_name, :email, :password, :current_password, :avatar_url, :bio, :location) }
   end
end
