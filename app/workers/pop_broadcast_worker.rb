class PopBroadcastWorker
  include Sidekiq::Worker

  #worker object that broadcasts that a post has been popped(favorited)
  def perform(post_id, user_id, feed_id = nil)

    #find the post being popped and the user who popped it
    post = Post.find post_id
    user = User.find user_id

    #check to see if broadcast is going to posts parent feed, or a delayed/party feed
    unless feed_id.present?
      feed_id = post.feed_id
    end

    #broadcast
    ActionCable.server.broadcast "#{post.feed_id}",
      post_id:    post.id,
      pops:       post.cached_votes_total,
      popper:     user.screen_name,
      poppee:     post.user.screen_name
  end
end
