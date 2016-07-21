json.user @user do |u|
  json.screen_name    u.screen_name
  json.email          u.email
  json.first_name     u.first_name
  json.last_name      u.last_name
  json.bio            u.bio
  json.location       u.location
  json.avatar         u.avatar.url
  json.avatar_thumb   u.avatar.thumb.url
end
