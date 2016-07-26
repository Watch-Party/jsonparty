class FeedsChannel < ApplicationCable::Channel
  def subscribed
    show = params["data"].first["show"]
    season = params["data"].first["season"]
    episode = params["data"].first["episode"]
    stop_all_streams
    stream_from "#{show}:s#{season}:e#{episode}"
  end

  def unsubscribed
    stop_all_streams
  end

  def post(data)
    show = params["data"].first["show"]
    season = params["data"].first["season"]
    episode = params["data"].first["episode"]
    content = data["message"]["content"]
    user = User.find params["data"].last["user_id"]
    feed = Feed.first

    post = feed.posts.new(
                          content: content,
                          time_in_episode: Time.now - feed.episode.air_date,
                          user: user
                          )
    post.save


    ActionCable.server.broadcast "#{show}:s#{season}:e#{episode}",
      content:    post.content,
      username:   post.user.screen_name,
      thumb_url:  post.user.avatar.thumb.url,
      timestamp:  Time.at(post.time_in_episode).utc.strftime("%M:%S")
  end
end
