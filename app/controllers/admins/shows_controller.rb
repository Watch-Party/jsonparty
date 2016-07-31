class Admins::ShowsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @shows = Show.where(confirmed: true)
  end

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
    if show.confirmed == true
      flash[:notice] = "Show already in Watch Party"
      redirect_to '/admins/show/new'
    else
      show.confirmed = true
      sfinder = SeasonsFinder.new show
      show.seasons = sfinder.seasons
      if show.save
        episodes = EpisodeIndexer.new(show)
        episodes.index
        redirect_to "/admins/show/#{show.id}/edit"
      else
        flash[:notice] = "Unable to add show!"
        render :new
      end
    end
  end

  def edit
    @show = Show.find params[:id]
  end

  def update
    show = Show.find params[:id]
    if show.update approved_params
      flash[:notice] = "Show Updated!"
      redirect_to "/admins/admin/#{current_admin.id}"
    else
      render :edit
    end
  end

  private

  def approved_params
    params.require(:show).permit(:title, :network, :summary)
  end
end
