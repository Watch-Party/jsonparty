class RegistrationsController < Devise::RegistrationsController
  include DeviseTokenAuth::Concerns::SetUserByToken
  respond_to :json
end
