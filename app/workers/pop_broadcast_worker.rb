class PopBroadcastWorker
  include Sidekiq::Worker

  def perform(post_id, user_id)
    post = Post.find post_id
    user = User.find user_id
    ActionCable.server.broadcast "#{post.feed_id}",
      post_id:    post.id,
      pops:       post.get_upvotes.size,
      popper:     user.screen_name,
      poppee:     post.user.screen_name
  end
end
