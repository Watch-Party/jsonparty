class UsersController < ApplicationController

  def show
    @user = User.find params[:id]
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    respond_to do |format|
      format.json { render json: { status: :ok} }
    end
  end

end
