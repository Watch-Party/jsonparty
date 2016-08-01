class EpisodeIndexer

  def initialize show
    @show = show
  end

  def index
    resp = HTTParty.get "http://api.tvmaze.com/shows/#{@show.tvrage_id}/episodes"
    resp.each do |e|
      add_episode e
    end
  end

  def update
    resp = HTTParty.get "http://api.tvmaze.com/shows/#{@show.tvrage_id}/episodes"
    resp.each do |e|
      unless @show.episodes.find_by(tvrage_e_id: e["id"]).present?
        add_episode e
      end
    end
  end

  private

  def add_episode e
    if e["number"].present?
      episode_number = e["number"]
    else
      episode_number = "special"
    end
    epi = @show.episodes.new(
                      title: e["name"],
                      air_date: e["airstamp"],
                      runtime: e["runtime"],
                      season: e["season"],
                      episode_number: episode_number,
                      tvrage_e_id: e["id"]
                      )
    epi.save!

    if epi.air_date > Time.now
      LiveFeedWoker.perform_at(
                              (epi.air_date - (1.hours + 20.minutes)),
                              epi.id
                              )
    end
  end
end
