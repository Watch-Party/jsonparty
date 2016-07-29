json.show do
  json.id           @show.id
  json.title        @show.title
  json.img_url      @show.cover_img_url
  json.seasons      @show.seasons
  json.description  @show.summary
  json.network      @show.network

  if @upcoming.present?
    json.upcoming_title    @upcoming.title
    json.upcoming_date     @upcoming.air_date.in_time_zone('Eastern Time (US & Canada)').strftime("%B %-d, %Y - %I:%M%p EST")
  else
    json.upcoming_title    "TBA"
    json.upcoming_date     "TBA"
  end

  json.recent_title       @recent.title
  json.recent_date        @recent.air_date.in_time_zone('Eastern Time (US & Canada)').strftime("%B %-d, %Y - %I:%M%p EST")
end
