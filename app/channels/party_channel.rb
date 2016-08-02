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
    viewtype = params["data"][2]["viewtype"]


    #start stream
    stream_from "#{feed.id}"

    ActionCable.server.broadcast "#{feed.id}",
      welcome: "You are in party channel #{feed.name}"

  end

  def unsubscribed
    stop_all_streams
  end

  def start(data)

    #initialization
    user = User.find(params["data"][1]["user_id"])
    feed = Feed.find_by(name: params["data"][3]["feed_name"])
    viewtype = params["data"][2]["viewtype"]

    #room can only start once
    unless feed.start_time.present?
      feed.start_time = Time.now
      feed.save

      df = DelayedFeed.new feed, viewtype, user
      df.start
    end
  end

  def post(data)

    #initialization
    user = User.find params["data"][1]["user_id"]
    feed = Feed.find_by(name: params["data"][3]["feed_name"])
    content = data["message"]["content"]

    #posts made before feed start are time_in_episode = 0
    if feed.start_time.present?
      time_in_episode = Time.now - feed.start_time
    else
      time_in_episode = 0
    end

    #create post and send it to broadcast worker
    post = feed.posts.new(
                          content: content,
                          time_in_episode: time_in_episode,
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

    #comments made before feed start are time_in_episode = 0
    if feed.start_time.present?
      time_in_episode = Time.now - feed.start_time
    else
      time_in_episode = 0
    end

    #create comment and send it to broadcast worker
    comment = post.comments.new(
                                content: content,
                                user: user,
                                time_in_episode: time_in_episode,
                                feed: feed)
    comment.save

  end
end
