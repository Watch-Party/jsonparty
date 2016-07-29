class PartyChannel < ApplicationCable::Channel
  def subscribed
    show = params["data"][0]["show"]
    season = params["data"][0]["season"]
    episode = params["data"][0]["episode"]

    unless user = User.find params["data"][1]["user_id"]
      reject
    end

    viewtype = params["data"][2]["viewtype"]

    stop_all_streams
    feed_name = params["data"][3]["feed_name"]
    show = Show.find_by(title: show)
    episode = show.episodes.find_by(season: season, episode_number: episode)

    if feed_name.present?
      unless feed = Feed.find_by(name: feed_name)
        reject
      end
    else
      feed = episode.feeds.new(
                              species: "delayed",
                              start_time: Time.now,
                              name: "#{episode.name}:#{sprintf '%05d', rand(1..99999)}"
                              )
    end

    stream_from "#{feed.id}"

    ActionCable.server.broadcast "#{feed.id}",
      welcome: "You are in party channel #{feed.name}"


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

    feed = Feed.find_by(name: params["data"][3]["feed_name"])

    post = feed.posts.new(
                          content: content,
                          time_in_episode: Time.now - feed.start_time,
                          user: user
                          )
    post.save

  end
end
