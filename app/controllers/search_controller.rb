class SearchController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :set_format

  def search
    @results = PgSearch.multisearch(params[:criteria])
  end

  def init
    @recent = Show.where(:created_at => 1.weeks.ago..Time.now)
    shows = Show.all
    @popular = shows.sort_by { |s| s.posts.count}.reverse.first(8)
  end

end
