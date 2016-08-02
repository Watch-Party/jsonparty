class PartyChannel < ApplicationCable::Channel
  def subscribed

    stop_all_streams

    #initialization
    unless user = User.find(params["data"][1]["user_id"])
      reject
    end
    feed_name = params["data"][3]["feed_name"]
    unless feed = Feed.find_by('lower(name) = ?', feed_name.downcase)
      reject
    end

    #start stream
    stream_from "#{feed.id}"

    #welcome to feed post
    ActionCable.server.broadcast "#{feed.id}",
      feed_name:  feed.name,
      post_id:    nil,
      content:    "Welcome to #{feed.name}",
      username:   "Watch Party",
      thumb_url:  "https://watch-party.s3.amazonaws.com/uploads/user/avatar/4/thumb_admin-account-dnn7-1.png",
      timestamp:  time_in_channel(feed),
      pops:       42
  end

  def unsubscribed
    stop_all_streams
  end

  def start(data)

    #initialization
    user = User.find(params["data"][1]["user_id"])
    feed = Feed.find_by(name: params["data"][3]["feed_name"])

    #room can only start once
    unless feed.start_time.present?
      feed.start_time = Time.now
      feed.save

      df = DelayedFeed.new feed, "all", user
      df.start

      ActionCable.server.broadcast "#{feed.id}",
        status: :started
    end
  end

  def post(data)

    #initialization
    user = User.find params["data"][1]["user_id"]
    feed = Feed.find_by(name: params["data"][3]["feed_name"])
    content = data["message"]["content"]

    #create post and send it to broadcast worker
    post = feed.posts.new(
                          content: content,
                          time_in_episode: time_in_channel(feed),
                          user: user
                          )
    post.save

  end

  def pop(data)

    #initialization
    user = User.find params["data"][1]["user_id"]
    feed = Feed.find_by(name: params["data"][3]["feed_name"])
    post = Post.find(data["message"]["post_id"])

    #pop(upvote) post and sent to broadcast worker
    post.upvote_by user
    PopBroadcastWorker.perform_async post.id, user.id, feed.id

  end

  def comment(data)

    #initialization
    user = User.find params["data"][1]["user_id"]
    feed = Feed.find_by(name: params["data"][3]["feed_name"])
    post = Post.find(data["message"]["post_id"])
    content = data["message"]["content"]

    #create comment and send it to broadcast worker
    comment = post.comments.new(
                                content: content,
                                user: user,
                                time_in_episode: time_in_channel(feed),
                                feed: feed)
    comment.save

  end

  private

  #posts and comments made before feed start are time_in_episode = 0
  def time_in_channel(feed)
    if feed.start_time.present?
      Time.now - feed.start_time
    else
      0
    end
  end
end
