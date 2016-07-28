class DelayedChannel < ApplicationCable::Channel
  def subscribed
    show = params["data"].first["show"]
    season = params["data"].first["season"]
    episode = params["data"].first["episode"]

    user = User.find params["data"].last["user_id"]

    stop_all_streams

    show = Show.find_by(title: show)
    episode = show.episodes.find_by(season: season, episode_number: episode)

    feed = episode.feeds.new(
                            species: "delayed",
                            start_time: Time.now,
                            name: "#{episode.id}:#{user.id}"
                            )

    stream_from "#{feed.id}"

    df = DelayedFeed.new feed
    df.start

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

    feed = episode.feeds.where(name: "#{episode.id}:#{user.id}").last

    post = feed.posts.new(
                          content: content,
                          time_in_episode: Time.now - feed.start_time,
                          user: user
                          )
    post.save

  end
end
