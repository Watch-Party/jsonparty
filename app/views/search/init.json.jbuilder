json.recent @recent do |rec|
  json.id       rec.id
  json.title    rec.title
  json.img_url  rec.cover_img_url
  json.show_added_on  rec.created_at.in_time_zone('Eastern Time (US & Canada)').strftime("%B %-d %Y - %I:%M%p EST")
end

json.popular @popular do |popu|
  json.id     popu.id
  json.title  popu.title
  json.img_url  popu.cover_img_url
  json.total_posts  popu.posts.count
  json.last_episode_posts   popu.episodes.last.posts.count
end
