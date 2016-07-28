class PostsController < ApplicationController

  def index
    showname = params[:showname].gsub(/\_/," ")
    show = Show.find_by(title: showname)
    episode = show.episodes.find_by(season: params[:season], episode_number: params[:episode])
    @posts = episode.posts.where("time_in_episode <= ?", 0).order(:time_in_episode).includes(:user)
  end

end
