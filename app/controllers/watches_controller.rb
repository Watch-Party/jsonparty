class WatchesController < ApplicationController

  def create
    w = Watch.new(watcher: current_user, watched_id: params[:id])
    if w.save
      respond_to do |format|
        format.json { render json: { status: "Success"} }
      end
    else
      respond_to do |format|
        format.json { render json: { status: "Unable to watch that user"} }
      end
    end
  end

  def destroy
    w = Watch.find_by(watcher: current_user, watched_id: params[:id])
    if w.delete
      respond_to do |format|
        format.json { render json: { status: "Success"} }
      end
    else
      respond_to do |format|
        format.json { render json: { status: "Unable to unwatch"} }
      end
    end
  end

end
