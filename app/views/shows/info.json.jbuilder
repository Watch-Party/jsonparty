json.show do
  json.id     @show.id
  json.title  @show.title
  json.img_url  @show.cover_img_url
  json.seasons @show.seasons
  json.description @show.summary
  if upcoming = @show.episodes.where("air_date >= ?", Time.now).first
    json.upcoming_title    upcoming.title
    json.upcoming_date     upcoming.air_date.in_time_zone('Eastern Time (US & Canada)').strftime("%B %-d, %Y - %I:%M%p EST")
  else
    json.upcoming          "TBA"
  end
  recent = @show.episodes.where("air_date <= ?", Time.now).last
  json.recent_title       recent.title
  json.recent_date        recent.air_date.in_time_zone('Eastern Time (US & Canada)').strftime("%B %-d, %Y - %I:%M%p EST")
end
