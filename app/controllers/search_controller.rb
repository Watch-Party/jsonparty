class SearchController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :set_format

  def user
    @users = User.search_for_user(params[:criteria])
  end

  def show
    @shows = Show.search_for_show(params[:criteria])
  end

  def init
    @recent = Show.where(confirmed: true, :created_at => 1.weeks.ago..Time.now)
    shows = Show.where(confirmed: true)
    @popular = shows.sort_by { |s| s.posts.count}.reverse.first(8)
  end

end
