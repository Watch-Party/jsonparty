class SearchController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :set_format
  before_action :authenticate_user!

  #search for users by screen_name and email (using pg_search_scope)
  def users
    @users = User.search_by_sn_and_email(params[:criteria]).where.not(confirmed_at: nil)
  end

  #search for shows by title (using pg_search_scope)
  def shows
    @shows = Show.search_by_title(params[:criteria]).where(active: true, confirmed: true)
  end

  #unused search for show titles and user emails/screen_names (using pg_search multisearch)
  # def search
  #   @results = PgSearch.multisearch(params[:criteria])
  # end

  #default search results (before the user had typed anything), displays popular and recently added shows
  def init
    @recent = Show.where(confirmed: true, active: true, :created_at => 1.weeks.ago..Time.now)
    @popular = Show.where(confirmed: true, active: true).select('shows.*, COUNT(posts.id) post_count').joins(:posts).group("shows.id").order("post_count DESC").limit(8)
  end

end
