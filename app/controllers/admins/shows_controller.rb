class Admins::ShowsController < ApplicationController

  def new
    @show = Show.new
  end

  def confirm
    showname = params[:show][:title]
    sfinder = ShowFinder.new showname
    @shows = sfinder.options
  end

  def create
    show = Show.find_by(tvrage_id: params[:tvrage_id])
    show.confirmed = true
    sfinder = SeasonsFinder.new show
    show.seasons = sfinder.seasons
    if show.save
      episodes = EpisodeIndexer.new(show)
      episodes.index
      respond_to do |format|
        format.json { render json: { status: "Show Added!"} }
      end
    else
      respond_to do |format|
        format.json { render json: { status: "Unable to add show"} }
      end
    end
  end
end
