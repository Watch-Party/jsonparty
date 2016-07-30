class DelayedChannel < ApplicationCable::Channel
  def subscribed
    # show = params["data"][0]["show"]
    # season = params["data"][0]["season"]
    # episode = params["data"][0]["episode"]

    episode_id = params["data"][0]["episode_id"]

    unless user = User.find(params["data"][1]["user_id"])
      reject
    end

    viewtype = params["data"][2]["viewtype"]

    stop_all_streams

    # show = Show.find_by(title: show)
    episode = Episode.find(episode_id)

    feed = episode.feeds.create(
                            species: "delayed",
                            start_time: Time.now,
                            name: "#{episode.id}:#{user.id}"
                            )

    stream_from "#{feed.id}"

    df = DelayedFeed.new feed, viewtype, user
    df.start

  end

  def unsubscribed
    stop_all_streams
  end

  def post(data)
    # show = params["data"][0]["show"]
    # season = params["data"][0]["season"]
    # episode = params["data"][0]["episode"]

    episode_id = params["data"][0]["episode_id"]

    content = data["message"]["content"]

    user = User.find params["data"][1]["user_id"]

    feed = Feed.where(name: "#{episode_id}:#{user.id}").last

    post = feed.posts.new(
                          content: content,
                          time_in_episode: Time.now - feed.start_time,
                          user: user
                          )
    post.save

  end

  def pop(data)
    user = User.find params["data"][1]["user_id"]

    episode_id = params["data"][0]["episode_id"]

    feed = Feed.where(name: "#{episode_id}:#{user.id}").last

    post = Post.find(data["message"]["post_id"])
    post.upvote_by user

    PopBroadcastWorker.perform_async post.id, user.id, feed.id

  end

  def comment(data)
    user = User.find params["data"][1]["user_id"]

    post = Post.find(data["message"]["post_id"])

    feed = Feed.where(name: "#{episode_id}:#{user.id}").last

    content = data["message"]["content"]

    comment = post.comments.new(
                                content: content,
                                user: user,
                                time_in_episode: Time.now - feed.start_time,
                                feed: feed)
    comment.save

  end
end
