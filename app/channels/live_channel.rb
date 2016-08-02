class LiveChannel < ApplicationCable::Channel
  def subscribed

    stop_all_streams

    #initialization
    unless user = User.find(params["data"][1]["user_id"])
      reject
    end
    episode_id = params["data"][0]["episode_id"]
    episode = Episode.find(episode_id)
    unless feed = episode.feeds.find_by(name: "live")
      reject
    end

    #start stream
    stream_from "#{feed.id}"

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
