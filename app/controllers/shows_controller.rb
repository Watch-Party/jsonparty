class ShowsController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :set_format
  before_action :authenticate_user!

  #get information for one show using the showname(title)
  def info
    showname = params[:showname].gsub(/\_/," ")
    @show = Show.find_by('lower(title) = ?', showname.downcase)
    @upcoming = @show.episodes.where("air_date >= ?", Time.now).first
    @recent = @show.episodes.where("air_date <= ?", Time.now).last
  end

  #gets the shows that a user has posted in recently
  def recent_for_user
    @shows = Show.joins(:posts).where('posts.user_id = ?', current_user.id).uniq.limit(5).includes(:episodes)
  end

end
