class ShowsController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :set_format

  def info
    showname = params[:showname].gsub(/\_/," ")
    @show = Show.find_by('lower(title) = ?', showname.downcase)
    @upcoming = @show.episodes.where("air_date >= ?", Time.now).first
    @recent = @show.episodes.where("air_date <= ?", Time.now).last
  end

  def index
    @shows = Show.all
  end

  def recent
    user = User.find params[:user]
    @shows = Show.joins(:posts).where('posts.user_id = ?', user.id).uniq.includes(:episodes).limit(5)
  end

  def update
    @show = Show.find params[:id]
  end

end
