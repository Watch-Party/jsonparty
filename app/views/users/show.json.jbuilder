json.user do
  json.screen_name    @user.screen_name
  json.email          @user.email
  json.first_name     @user.first_name
  json.last_name      @user.last_name
  json.bio            @user.bio
  json.location       @user.location
  json.avatar         @user.avatar.url
  json.avatar_thumb   @user.avatar.thumb.url
  json.total_posts    @user.posts.count
end
