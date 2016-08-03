class PostsController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :set_format
  before_action :authenticate_user!

  #gets all posts that were posted before episode started
  def index
    showname = params[:showname].gsub(/\_/," ")
    show = Show.find_by('lower(title) = ?', showname.downcase)
    episode = show.episodes.find_by(season: params[:season], episode_number: params[:episode])
    @posts = episode.posts.where("time_in_episode <= ?", 0).includes(:user).order(:time_in_episode)
  end

end
