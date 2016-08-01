class PopBroadcastWorker
  include Sidekiq::Worker

  def perform(post_id, user_id, feed_id = nil)
    post = Post.find post_id
    user = User.find user_id

    unless feed_id.present?
      feed_id = post.feed_id
    end

    ActionCable.server.broadcast "#{post.feed_id}",
      post_id:    post.id,
      pops:       post.cached_votes_total,
      popper:     user.screen_name,
      poppee:     post.user.screen_name
  end
end
