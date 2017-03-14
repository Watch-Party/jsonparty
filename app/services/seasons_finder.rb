class SeasonsFinder

  #service object that finds the number of seasons for a given show
  def initialize show
    @show = show
  end

  #method that calculates them (only counts seasons that have an announced premiere date)
  def seasons

    #API call to tvmaze
    resp = HTTParty.get "http://api.tvmaze.com/shows/#{@show.tvrage_id}/seasons"

    if resp.code == 200
      #deletes seasons if the premiere is not announced
      current_seasons = resp.map { |s| s["premiereDate"]}.delete_if { |date| date.nil?}
      current_seasons.length
    end
  end
end
