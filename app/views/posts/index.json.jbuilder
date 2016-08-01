json.posts @posts do |post|
  json.id         post.id
  json.username   post.user.screen_name
  json.thumb_url  post.user.avatar.thumb.url
  json.timestamp  "-#{(Time.at(-(post.time_in_episode)).utc.strftime("%M:%S"))}"
  json.content    post.content
  json.pops       post.cached_votes_total
end
