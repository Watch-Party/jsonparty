class DelayedChannel < ApplicationCable::Channel
  def subscribed
    show = params["data"].first["show"]
    season = params["data"].first["season"]
    episode = params["data"].first["episode"]
    user_id = params["data"].last["user_id"]

    stop_all_streams

    stream_from "#{show}:s#{season}:e#{episode}:u#{user_id}"
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
                          user: user,
                          feed_name: "#{show}:s#{season}:e#{episode}:u#{user.id}"
                          )
    post.save

  end
end
