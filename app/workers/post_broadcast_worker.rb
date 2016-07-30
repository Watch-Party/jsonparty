class PostBroadcastWorker
  include Sidekiq::Worker

  def perform(post_id, feed_id = nil)
    post = Post.find post_id
    unless feed_id.present?
      feed_id = post.feed_id
    end

    ActionCable.server.broadcast "#{feed_id}",
      post_id:    post.id,
      content:    post.content,
      username:   post.user.screen_name,
      thumb_url:  post.user.avatar.thumb.url,
      timestamp:  Time.at(post.time_in_episode).utc.strftime("%M:%S"),
      pops:       post.get_upvotes.size
  end
end
