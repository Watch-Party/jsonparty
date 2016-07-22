class ShowFinder

  def initialize showname
    @showname = showname
  end

  def options
    shows = []
    resp = HTTParty.get "http://api.tvmaze.com/search/shows?q=#{@showname}"
    resp.each do |s|
      if s["show"]["image"].present?
        img_url = s["show"]["image"]["original"]
      else
        img_url = 'https://s3.amazonaws.com/watch-party/uploads/fallback/image-not-found.png'
      end
      option = Show.new(
              title: s["show"]["name"].downcase,
              cover_img_url: img_url,
              summary: s["show"]["summary"],
              tvrage_id: s["show"]["id"]
              )
      option.save
      shows.push option
    end
    return shows
  end

end
