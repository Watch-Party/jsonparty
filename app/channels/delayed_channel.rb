class DelayedChannel < ApplicationCable::Channel
  def subscribed

    stop_all_streams

    #initialization
    unless user = User.find(params["data"][1]["user_id"])
      reject
    end
    episode_id = params["data"][0]["episode_id"]
    episode = Episode.find(episode_id)
    viewtype = params["data"][2]["viewtype"]

    #create personal feed and stream from it
    feed = episode.feeds.create(
                            species: "delayed",
                            start_time: Time.now,
                            name: "delayed:#{episode.id}:#{user.id}"
                            )

    #start stream
    stream_from "#{feed.id}"

    #welcome to feed post
    post = Post.find(42) #db post made for this purpose
    ActionCable.server.broadcast "#{feed.id}",
      feed_name:  feed.name,
      post_id:    post.id,
      content:    "Welcome to '#{feed.name}'",
      username:   "Watch Party",
      thumb_url:  "https://s3.amazonaws.com/watch-party/uploads/fallback/thumb_stylized-retro-tv-15240194.jpg",
      timestamp:  Time.at(Time.now - feed.start_time).utc.strftime("%M:%S"),
      pops:       post.cached_votes_total

    #queue up posts for delayed
    df = DelayedFeed.new feed, viewtype, user
    df.start

  end

  def unsubscribed
    stop_all_streams
  end

  def post(data)

    #initialization
    user = User.find params["data"][1]["user_id"]
    episode_id = params["data"][0]["episode_id"]
    feed = Feed.where(name: "#{episode_id}:#{user.id}").last
    content = data["message"]["content"]

    #create post and send it to broadcast worker
    post = feed.posts.new(
                          content: content,
                          time_in_episode: Time.now - feed.start_time,
                          user: user
                          )
    post.save

  end

  def pop(data)

    #initialization
    user = User.find params["data"][1]["user_id"]
    episode_id = params["data"][0]["episode_id"]
    feed = Feed.where(name: "#{episode_id}:#{user.id}").last
    post = Post.find(data["message"]["post_id"])

    #pop(upvote) post and sent to broadcast worker
    post.upvote_by user
    PopBroadcastWorker.perform_async post.id, user.id, feed.id

  end

  def comment(data)
    user = User.find params["data"][1]["user_id"]
    episode_id = params["data"][0]["episode_id"]
    feed = Feed.where(name: "#{episode_id}:#{user.id}").last
    post = Post.find(data["message"]["post_id"])
    content = data["message"]["content"]

    #comments made before feed start are time_in_episode = 0
    comment = post.comments.new(
                                content: content,
                                user: user,
                                time_in_episode: Time.now - feed.start_time,
                                feed: feed)
    comment.save

  end
end
