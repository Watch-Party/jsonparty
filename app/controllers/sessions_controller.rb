class SessionsController < Devise::SessionsController
  include DeviseTokenAuth::Concerns::SetUserByToken
  respond_to :json
end
