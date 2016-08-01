class SearchController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :set_format

  def users
    @users = User.search_by_sn_and_email(params[:criteria])
  end

  def shows
    @shows = Show.search_by_title(params[:criteria]).where(active: true)
  end

  # def search
  #   @results = PgSearch.multisearch(params[:criteria])
  # end

  def init
    @recent = Show.where(confirmed: true, active: true, :created_at => 1.weeks.ago..Time.now)
    @popular = Show.where(confirmed: true, active: true).select('shows.*, COUNT(posts.id) post_count').joins(:posts).group("shows.id").order("post_count DESC").limit(8)
  end

end
