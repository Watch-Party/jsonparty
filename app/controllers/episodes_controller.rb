class EpisodesController < ApplicationController

  def show
    @episode = Episode.find params[:id]
  end

  def index
    @show = Show.find params[:id]
    @episodes = @show.episodes.all
  end

  def upcoming
    @episodes = Episode.where(:air_date => Time.now..2.days.from_now)
  end

  def get_id
    showname = params[:showname].gsub(/\_/," ")
    show = Show.find_by(title: showname)
    episode = show.episodes.find_by(season: params[:season], episode_number: params[:episode])
    respond_to do |format|
      format.json { render json: { episode_id: episode.id} }
    end
  end

  def create
    @show = Show.find params[:id]
    @episode = @show.episodes.new
  end

  def update
    @show = Show.find params[:id]
  end

  def destroy
    @episode = Episode.find params[:id]
    @episode.destroy
    respond_to do |format|
      format.json { render json: { status: :ok} }
    end
  end
end
