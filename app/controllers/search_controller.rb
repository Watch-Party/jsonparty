class SearchController < ApplicationController

  def search
    results = PgSearch.multisearch(params[:criteria])
  end

end
