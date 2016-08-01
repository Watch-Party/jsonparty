class ShowsController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :set_format

  def info
    showname = params[:showname].gsub(/\_/," ")
    @show = Show.find_by('lower(title) = ?', showname.downcase)
    @upcoming = @show.episodes.where("air_date >= ?", Time.now).first
    @recent = @show.episodes.where("air_date <= ?", Time.now).last
  end

  def recent
    @shows = Show.joins(:posts).where('posts.user_id = ?', current_user.id).uniq.limit(5).includes(:episodes)
  end

end
