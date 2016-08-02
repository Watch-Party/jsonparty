class UsersController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :set_format

  #get information for one user using the user_id
  def show
    @user = User.find params[:id]
  end

end
