class FeedsController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :set_format

  def show
    @feed = Feed.find(params[:id]).includes(:user)
  end

  def create

  end

end
