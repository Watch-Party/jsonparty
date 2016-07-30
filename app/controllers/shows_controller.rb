class ShowsController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :set_format

  def info
    showname = params[:showname].gsub(/\_/," ")
    @show = Show.find_by(title: showname)
    @upcoming = @show.episodes.where("air_date >= ?", Time.now).first
    @recent = @show.episodes.where("air_date <= ?", Time.now).last
  end

  def index
    @shows = Show.all
  end

  def recent
    @shows = (Post.where(user: current_user).includes(:feed)).map {|p| p.show }.uniq
  end

  def update
    @show = Show.find params[:id]
  end

end
