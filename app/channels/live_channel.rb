class LiveChannel < ApplicationCable::Channel
  def subscribed
    show = params["data"][0]["show"]
    season = params["data"][0]["season"]
    episode = params["data"][0]["episode"]

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

    user = User.find params["data"][1]["user_id"]

    show = Show.find_by(title: show)
    episode = show.episodes.find_by(season: season, episode_number: episode)
    feed = episode.feeds.find_by(name: "live")

    post = feed.posts.new(
                          content: content,
                          time_in_episode: Time.now - feed.start_time,
                          user: user
                          )
    post.save

  end

  def pop(data)
    user = User.find params["data"][1]["user_id"]

    post = Post.find(data["message"]["post_id"])
    post.upvote_by user

    PopBroadcastWorker.perform_async post.id, user.id

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
    user = User.find params["data"][1]["user_id"]

    post = Post.find(data["message"]["post_id"])

    content = data["message"]["content"]

    comment = post.comments.new(
                                content: content,
                                user: user
                                )
    comment.save

  end
end
