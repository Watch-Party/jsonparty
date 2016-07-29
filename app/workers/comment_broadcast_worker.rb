class CommentBroadcastWorker
  include Sidekiq::Worker

  def perform(comment_id)
    comment = Comment.find comment_id
    post = comment.post
    ActionCable.server.broadcast "#{post.feed_id}",
      post_id:    post.id,
      content:    post.content,
      username:   post.user.screen_name,
      thumb_url:  post.user.avatar.thumb.url,
      timestamp:  Time.at(post.time_in_episode).utc.strftime("%M:%S"),
      pops:       post.get_upvotes.size,
      comments:   
                  post.comments.where("time_in_episode <= ?", comment.time_in_episode).each do |c|
                    {comment_id:   c.id,
                    content:      c.content,
                    username:     c.user.screen_name,
                    thumb_url:    c.user.avatar.thumb.url,
                    timestamp:    Time.at(c.time_in_episode).utc.strftime("%M:%S")}
                  end

  end
end
