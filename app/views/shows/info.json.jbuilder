json.show do
  json.id           @show.id
  json.title        @show.title
  json.img_url      @show.cover_img_url
  json.description  @show.summary
  json.network      @show.network

  if @upcoming.present?
    json.upcoming_id       @upcoming.id
    json.upcoming_title    @upcoming.title
    json.upcoming_date     @upcoming.air_date.in_time_zone('Eastern Time (US & Canada)').strftime("%B %-d, %Y - %I:%M%p EST")
  else
    json.upcoming_title    "TBA"
    json.upcoming_date     "TBA"
  end
  if @recent.present?
    json.recent_id          @recent.id
    json.recent_title       @recent.title
    json.recent_date        @recent.air_date.in_time_zone('Eastern Time (US & Canada)').strftime("%B %-d, %Y - %I:%M%p EST")
  else
    json.recent_title    "None"
    json.recent_date     "None"
  end

  json.seasons (1..@show.seasons).reverse_each do |season|
    json.season     season
    json.episodes   @show.episodes.select {|e| e.season == season} do |episode|
      json.episode  episode.episode_number
      json.info do
        json.id   episode.id
      end
    end
  end
end
