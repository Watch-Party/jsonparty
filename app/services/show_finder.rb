class ShowFinder

  def initialize showname
    @showname = showname
  end

  def options
    shows = []
    resp = HTTParty.get "http://api.tvmaze.com/search/shows?q=#{@showname}"
    resp.each do |s|
      option = Show.new(
              title: s["show"]["name"],
              cover_img_url: s["show"]["image"]["original"],
              summary: s["show"]["summary"],
              tvrage_id: s["show"]["id"]
              )
      option.save
      shows.push option
    end
    return shows
  end

end
