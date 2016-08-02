class EpisodesController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :set_format

  def info
    @episode = Episode.find params[:id]
  end

  def upcoming
    @episodes = Episode.where(:air_date => Time.now..3.days.from_now).order(:air_date).includes(:show)
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
                            name: get_feed_name(episode)
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

  private

  def get_feed_name(episode)
    name = "#{episode.title}:#{sprintf '%05d', rand(1..999999)}"
    if Feed.find_by(name: name).present?
      get_feed_name(episode)
    else
      name
    end
  end
end
