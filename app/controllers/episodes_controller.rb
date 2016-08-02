class EpisodesController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :set_format

  def info
    @episode = Episode.find params[:id]
  end

  def index
    @show = Show.find params[:id]
    @episodes = @show.episodes.all
  end

  def upcoming
    @episodes = Episode.where(:air_date => Time.now..7.days.from_now).order(:air_date).includes(:show)
  end

  def get_id
    showname = params[:showname].gsub(/\_/," ")
    show = Show.find_by('lower(title) = ?', showname.downcase)
    if episode = show.episodes.find_by(season: params[:season], episode_number: params[:episode])
      respond_to do |format|
        format.json { render json: { episode_id: episode.id} }
      end
    else
      respond_to do |format|
        format.json { render json: { status: "Episode not found"} }
      end
    end
  end

  def new_party
    episode = Episode.find(params[:episode_id])
    feed = episode.feeds.new(
                            species: "delayed",
                            name: "#{episode.title}:#{sprintf '%05d', rand(1..99999)}"
                            )
    if feed.save
      respond_to do |format|
        format.json { render json: { feed_name: feed.name} }
      end
    else
      respond_to do |format|
        format.json { render json: { status: "Unable to process this request"} }
      end
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
