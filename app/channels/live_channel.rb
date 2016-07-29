class LiveChannel < ApplicationCable::Channel
  def subscribed
    show = params["data"][0]["show"]
    season = params["data"][0]["season"]
    episode = params["data"][0]["episode"]

    connection_store[:current_user_id] = params["data"][1]["user_id"]

    stop_all_streams

    show = Show.find_by(title: show)
    episode = show.episodes.find_by(season: season, episode_number: episode)
    feed = episode.feeds.find_by(name: "live")

    stream_from "#{feed.id}"
  end

  def unsubscribed
    stop_all_streams
  end

  def post(data)
    show = params["data"][0]["show"]
    season = params["data"][0]["season"]
    episode = params["data"][0]["episode"]

    content = data["message"]["content"]

    show = Show.find_by(title: show)
    episode = show.episodes.find_by(season: season, episode_number: episode)
    feed = episode.feeds.find_by(name: "live")

    post = feed.posts.new(
                          content: content,
                          time_in_episode: Time.now - feed.start_time,
                          user_id: connection_store[:current_user_id]
                          )
    post.save

  end

  def pop(data)
    post = Post.find(data["message"]["post_id"])
    post.upvote_by user

    PopBroadcastWorker.perform_async post.id, connection_store[:current_user_id]

  end

  def ping(data)
    show = params["data"][0]["show"]
    season = params["data"][0]["season"]
    episode = params["data"][0]["episode"]

    show = Show.find_by(title: show)
    episode = show.episodes.find_by(season: season, episode_number: episode)
    feed = episode.feeds.find_by(name: "live")

    ActionCable.server.broadcast "#{feed.id}",
    pong: "#{current_user.screen_name}"
  end

  def comment(data)
    post = Post.find(data["message"]["id"])

    content = data["message"]["content"]

    comment = post.comments.new(
                                content: content,
                                user_id: connection_store[:current_user_id]
                                )
    comment.save

  end
end
