class EpisodeIndexer

  def initialize show
    @show = show
  end

  def index
    resp = HTTParty.get "http://api.tvmaze.com/shows/#{@show.tvrage_id}/episodes?specials=1"
    resp.each do |e|
      add_episode e
    end
  end

  def update
    resp = HTTParty.get "http://api.tvmaze.com/shows/#{@show.tvrage_id}/episodes?specials=1"
    resp.each do |e|
      unless @show.episodes.find_by(tvrage_e_id: e["id"]).present?
        add_episode e
      end
    end
  end

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

    epi.feeds.create!(species: "live",
                      start_time: epi.air_date,
                      name: "live"
                      )
  end
end
