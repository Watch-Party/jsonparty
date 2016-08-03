class PostBroadcastWorker
  include Sidekiq::Worker

  #worker object that broadcasts a post
  def perform(post_id, feed_id = nil)

    #find the post
    post = Post.find post_id

    #check to see if broadcast is going to posts parent feed, or a delayed/party feed
    unless feed_id.present?
      feed_id = post.feed_id
    end
    
    #broadcast
    ActionCable.server.broadcast "#{feed_id}",
      feed_name:  post.feed.name,
      post_id:    post.id,
      content:    post.content,
      username:   post.user.screen_name,
      thumb_url:  post.user.avatar.thumb.url,
      timestamp:  time_in_episode(post),
      pops:       post.cached_votes_total
  end

  #formatting timestamp
  def time_in_episode(object)
    if object.time_in_episode < 0
      "-#{(Time.at(-(object.time_in_episode)).utc.strftime("%M:%S"))}"
    else
      Time.at(object.time_in_episode).utc.strftime("%M:%S")
    end
  end
end
