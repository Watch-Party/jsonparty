class LiveChannel < ApplicationCable::Channel
  def subscribed

    stop_all_streams

    #initialization
    unless user = User.find(params["data"][1]["user_id"])
      reject
    end
    episode_id = params["data"][0]["episode_id"]
    episode = Episode.find(episode_id)
    if feed = episode.feeds.find_by(name: "live")
      #create personal feed for private posts (not fully emplimented)
      personal_feed = episode.feeds.create(
                              species: "personal live",
                              start_time: Time.now,
                              name: "live:#{episode_id}:#{user.id}"
                              )
    else
      reject
    end

    #start stream
    stream_from "#{feed.id}"
    stream_from "#{personal_feed.id}"

    #welcome to feed post
    post = Post.find(42) #db post made for this purpose
    ActionCable.server.broadcast "#{personal_feed.id}",
      feed_name:  feed.name,
      post_id:    post.id,
      content:    "Welcome to '#{episode.title}:live",
      username:   "Watch Party",
      thumb_url:  "https://s3.amazonaws.com/watch-party/uploads/fallback/thumb_stylized-retro-tv-15240194.jpg",
      timestamp:  ((Time.now - episode.air_date) < 0) ? "-#{(Time.at(-(Time.now - episode.air_date)).utc.strftime("%M:%S"))}" : Time.at(Time.now - episode.air_date).utc.strftime("%M:%S"),
      pops:       post.cached_votes_total
  end

  def unsubscribed
    stop_all_streams
  end

  def post(data)

    #initialization
    user = User.find params["data"][1]["user_id"]
    episode_id = params["data"][0]["episode_id"]
    episode = Episode.find(episode_id)
    feed = episode.feeds.find_by(name: "live")
    content = data["message"]["content"]

    #create post and send it to broadcast worker
    post = feed.posts.new(
                          content: content,
                          time_in_episode: Time.now - episode.air_date,
                          user: user
                          )
    post.save

  end

  def pop(data)

    #initialization
    user = User.find params["data"][1]["user_id"]
    post = Post.find(data["message"]["post_id"])

    #pop(upvote) post and sent to broadcast worker
    post.upvote_by user
    PopBroadcastWorker.perform_async post.id, user.id

  end

  def comment(data)

    #initialization
    user = User.find params["data"][1]["user_id"]
    episode_id = params["data"][0]["episode_id"]
    episode = Episode.find(episode_id)
    post = Post.find(data["message"]["post_id"])
    feed = post.feed
    content = data["message"]["content"]

    #create comment and send it to broadcast worker
    comment = post.comments.new(
                                content: content,
                                user: user,
                                time_in_episode: Time.now - episode.air_date,
                                feed: feed
                                )
    comment.save

  end
end
