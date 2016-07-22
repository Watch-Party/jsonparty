class FeedsController < ApplicationController

  def show
    @feed = Feed.find_by(something)
  end

  def create
    
  end

end
