class SeasonsFinder

  def initialize show
    @show = show
  end

  def seasons
    resp = HTTParty.get "http://api.tvmaze.com/shows/#{@show.tvrage_id}/seasons"
    current_seasons = resp.map { |s| s["premiereDate"]}.delete_if { |date| date.nil?}
    current_seasons.length
  end
end
