class PostBroadcastWorker
  include Sidekiq::Worker

  def perform(post_id)
    post = Post.find post_id
    ActionCable.server.broadcast "#{post.feed_id}",
      post_id:    post.id,
      content:    post.content,
      username:   post.user.screen_name,
      thumb_url:  post.user.avatar.thumb.url,
      timestamp:  Time.at(post.time_in_episode).utc.strftime("%M:%S")
  end
end
