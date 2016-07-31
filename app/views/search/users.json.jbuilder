json.users @users do |u|
  json.id           u.id
  json.screen_name  u.screen_name
  json.email        u.email
end
