class ShowsController < ApplicationController

  def info
    showname = params[:showname].gsub(/\_/," ")
    @show = Show.find_by(title: showname)
    @upcoming = @show.episodes.where("air_date >= ?", Time.now).first
    @recent = @show.episodes.where("air_date <= ?", Time.now).last
  end

  def index
    @shows = Show.all
  end

  def new
    showname = params[:showname].gsub(/\_/," ")
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

  def recent
    @shows = (Post.where(user: current_user).includes(:feed)).map {|p| p.show }.uniq
  end

  def update
    @show = Show.find params[:id]
  end

  def destroy
    @show = Show.find params[:id]
    @show.destroy
    respond_to do |format|
      format.json { render json: { status: :ok} }
    end
  end
end
