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
                            name: "#{episode.title}:delayed:#{user.id}"
                            )

    #start stream
    stream_from "#{feed.id}"

    #welcome to feed post
    WelcomeMessageWorker.perform_async(feed.id)

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
    feed = Feed.where(name: "delayed:#{episode_id}:#{user.id}").last
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
    feed = Feed.where(name: "delayed:#{episode_id}:#{user.id}").last
    post = Post.find(data["message"]["post_id"])

    #pop(upvote) post and sent to broadcast worker
    post.upvote_by user
    PopBroadcastWorker.perform_async post.id, user.id, feed.id

  end

  def comment(data)
    user = User.find params["data"][1]["user_id"]
    episode_id = params["data"][0]["episode_id"]
    feed = Feed.where(name: "delayed:#{episode_id}:#{user.id}").last
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
