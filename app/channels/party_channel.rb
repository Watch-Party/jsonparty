class PartyChannel < ApplicationCable::Channel
  def subscribed

    stop_all_streams

    unless user = User.find(params["data"][1]["user_id"])
      reject
    end

    viewtype = params["data"][2]["viewtype"]

    feed_name = params["data"][3]["feed_name"]
    unless feed = Feed.find_by(name: feed_name)
      reject
    end


    stream_from "#{feed.id}"

    ActionCable.server.broadcast "#{feed.id}",
      welcome: "You are in party channel #{feed.name}"

  end

  def unsubscribed
    stop_all_streams
  end

  def start(data)

    user = User.find(params["data"][1]["user_id"])

    viewtype = params["data"][2]["viewtype"]

    feed = Feed.find_by(name: params["data"][3]["feed_name"])

    unless feed.start_time.present?
      feed.start_time = Time.now
      feed.save

      df = DelayedFeed.new feed, viewtype, user
      df.start
    end
  end

  def post(data)

    content = data["message"]["content"]

    user = User.find params["data"][1]["user_id"]

    feed = Feed.find_by(name: params["data"][3]["feed_name"])

    if feed.start_time.present?
      time_in_episode = Time.now - feed.start_time
    else
      time_in_episode = 0
    end

    post = feed.posts.new(
                          content: content,
                          time_in_episode: time_in_episode,
                          user: user
                          )
    post.save

  end

  def pop(data)
    user = User.find params["data"][1]["user_id"]

    feed = Feed.find_by(name: params["data"][3]["feed_name"])

    post = Post.find(data["message"]["post_id"])
    post.upvote_by user

    PopBroadcastWorker.perform_async post.id, user.id, feed.id

  end

  def comment(data)
    user = User.find params["data"][1]["user_id"]

    post = Post.find(data["message"]["post_id"])

    feed = Feed.find_by(name: params["data"][3]["feed_name"])

    if feed.start_time.present?
      time_in_episode = Time.now - feed.start_time
    else
      time_in_episode = 0
    end

    content = data["message"]["content"]

    comment = post.comments.new(
                                content: content,
                                user: user,
                                time_in_episode: time_in_episode,
                                feed: feed)
    comment.save

  end
end
