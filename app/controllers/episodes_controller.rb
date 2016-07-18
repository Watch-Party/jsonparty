class EpisodesController < ApplicationController

  def show
    @episode = Episode.find params[:id]
  end

  def index
    @show = Show.find params[:id]
    @episodes = @show.episodes.all
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
