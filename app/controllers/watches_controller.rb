class WatchesController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :set_format
  before_action :authenticate_user!

  #creates a watching/watched relationship between current_user and another user by user_id
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

  #destroys (unwatch) a watching/watched relationship between current_user and another user by user_id
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
