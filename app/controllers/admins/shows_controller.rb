class Admins::ShowsController < ApplicationController
  before_action :authenticate_admin!

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
      flash[:notice] = "Show added!"
      redirect_to "/admins/admin/#{current_admin.id}"
    else
      flash[:notice] = "Unable to add show!"
      render :new
    end
  end
end
