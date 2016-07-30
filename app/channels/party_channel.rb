class PartyChannel < ApplicationCable::Channel
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

    episode = Episode.find(episode_id)

    feed_name = params["data"][3]["feed_name"]
    unless feed = Feed.find_by(name: feed_name)
      reject
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
    # show = params["data"][0]["show"]
    # season = params["data"][0]["season"]
    # episode = params["data"][0]["episode"]

    episode_id = params["data"][0]["episode_id"]

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

  def pop(data)
    user = User.find params["data"][1]["user_id"]

    episode_id = params["data"][0]["episode_id"]

    feed = Feed.find_by(name: params["data"][3]["feed_name"])

    post = Post.find(data["message"]["post_id"])
    post.upvote_by user

    PopBroadcastWorker.perform_async post.id, user.id, feed.id

  end

  def comment(data)
    user = User.find params["data"][1]["user_id"]

    post = Post.find(data["message"]["post_id"])

    episode_id = params["data"][0]["episode_id"]

    feed = Feed.find_by(name: params["data"][3]["feed_name"])

    content = data["message"]["content"]

    comment = post.comments.new(
                                content: content,
                                user: user,
                                time_in_episode: Time.now - feed.start_time,
                                feed: feed)
    comment.save

  end
end
