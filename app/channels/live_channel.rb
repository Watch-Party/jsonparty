class LiveChannel < ApplicationCable::Channel
  def subscribed
    show = params["data"].first["show"]
    season = params["data"].first["season"]
    episode = params["data"].first["episode"]

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
    show = params["data"].first["show"]
    season = params["data"].first["season"]
    episode = params["data"].first["episode"]

    content = data["message"]["content"]

    user = User.find params["data"].last["user_id"]

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

  def pop
    user = User.find params["data"].last["user_id"]

    post = Post.find(data["message"]["id"])
    post.upvote_by user

    PopBroadcastWoker.perform_async post.id, user.id

  end
end
