class ShowsController < ApplicationController

  def show
    @show = Show.find params[:id]
  end

  def index
    @shows = Show.all
  end

  def create

  end

  def confirm

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
