class PartyChannel < ApplicationCable::Channel
  def subscribed

    stop_all_streams

    #initialization
    unless user = User.find(params["data"][1]["user_id"])
      reject
    end
    feed_name = params["data"][3]["feed_name"]
    if feed = Feed.find_by('lower(name) = ?', feed_name.downcase)
      #create personal feed for private posts (not fully emplimented)
      episode = feed.episode
      personal_feed = episode.feeds.create(
                              species: "personal party",
                              start_time: Time.now,
                              name: "#{feed.name}:#{user.id}"
                              )
    else
      reject
    end

    #start stream
    stream_from "#{feed.id}"
    stream_from "#{personal_feed.id}"

    #welcome to feed post
    #WelcomeMessageWorker.perform_in(1.seconds, personal_feed.id)
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
