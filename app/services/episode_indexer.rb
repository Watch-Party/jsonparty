class EpisodeIndexer

  def initialize show
    @show = show
  end

  def index
    resp = HTTParty.get "http://api.tvmaze.com/shows/#{@show.tvrage_id}/episodes"
    resp.each do |e|
      epi = @show.episodes.new(
                        title: e["name"],
                        air_date: e["airstamp"],
                        runtime: e["runtime"],
                        season: e["season"],
                        episode_number: e["number"]
                        )
      epi.save
    end
  end
end
