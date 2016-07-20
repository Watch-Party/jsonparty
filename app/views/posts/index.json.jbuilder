json.posts @posts do |post|
  json.username   post.user.screen_name
  json.thumb_url  post.user.avatar.thumb.url
  json.timestamp  (post.created_at.in_time_zone('Eastern Time (US & Canada)')).strftime("%B %-d %Y - %I:%M%p EST")
  json.content    post.content
end
