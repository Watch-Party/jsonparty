class Admins::ShowsController < ApplicationController
  before_action :authenticate_admin!

  #typical index method, ordered by demo status then show title
  def index
    @shows = Show.where(confirmed: true).order(demo: :desc).order(:title)
  end

  #helper for new view
  def new
    @show = Show.new
  end

  #sends show search title to showfinder, then presents the options
  def confirm
    showname = params[:show][:title]
    sfinder = ShowFinder.new showname
    @shows = sfinder.options
  end

  #when a show is chosen to be added, checks to see if its already in the app,
  #if not, it confirms the show, and sends show to EpisodeIndexer to get
  #episode info from tvrage
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

  #helper for edit view
  def edit
    @show = Show.find params[:id]
  end

  #updates show based on user input
  def update
    show = Show.find params[:id]
    if show.update approved_params
      flash[:notice] = "Show Updated!"
      redirect_to "/admins/admin/#{current_admin.id}"
    else
      render :edit
    end
  end

  #makes it so a show will not show up in the app
  def deactivate
    show = Show.find params[:id]
    show.active = false
    show.save

    flash[:notice] = "Show Deactivated!"
    redirect_to "/admins/shows"
  end

  #makes it so a deactivated show will once again appear in the app
  def activate
    show = Show.find params[:id]
    show.active = true
    show.save

    flash[:notice] = "Show Activated!"
    redirect_to "/admins/shows"
  end

  private

  def approved_params
    params.require(:show).permit(:title, :network, :summary)
  end
end
