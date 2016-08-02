class UsersController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :set_format

  def show
    @user = User.find params[:id]		
  end

end
