json.user do
  json.username       @user.screen_name
  json.email          @user.email
  json.first_name     @user.first_name
  json.last_name      @user.last_name
  json.bio            @user.bio
  json.location       @user.location
  json.avatar         @user.avatar.url
  json.avatar_thumb   @user.avatar.thumb.url
  json.total_posts    @user.posts.count
  json.watching     @user.watched do |w1|
    json.user_id      w1.id
    json.username     w1.screen_name
  end
  json.watched_by   @user.watchers do |w2|
    json.user_id      w2.id
    json.username     w2.screen_name
  end
end
