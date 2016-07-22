class FeedsController < ApplicationController

  def show
    @feed = Feed.find(params[:id]).includes(:user)
  end

  def create

  end

end
