class DelayedChannel < ApplicationCable::Channel
  def subscribed
    show = params["data"][0]["show"]
    season = params["data"][0]["season"]
    episode = params["data"][0]["episode"]

    unless user = User.find params["data"][1]["user_id"]
      reject
    end

    viewtype = params["data"][2]["viewtype"]

    stop_all_streams

    show = Show.find_by(title: show)
    episode = show.episodes.find_by(season: season, episode_number: episode)

    feed = episode.feeds.new(
                            species: "delayed",
                            start_time: Time.now,
                            name: "#{episode.id}:#{user.id}"
                            )

    stream_from "#{feed.id}"

    df = DelayedFeed.new feed viewtype user
    df.start

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

    feed = Feed.where(name: "#{episode.id}:#{user.id}").last

    post = feed.posts.new(
                          content: content,
                          time_in_episode: Time.now - feed.start_time,
                          user: user
                          )
    post.save

  end
end
