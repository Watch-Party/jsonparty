class CommentBroadcastWorker
  include Sidekiq::Worker

  def perform(comment_id, feed_id = nil)
    comment = Comment.find comment_id
    post = comment.post

    unless feed_id.present?
      feed_id = post.feed_id
    end

    comments = find_comments(comment, post)

    ActionCable.server.broadcast "#{feed_id}",
      post_id:    post.id,
      content:    post.content,
      username:   post.user.screen_name,
      thumb_url:  post.user.avatar.thumb.url,
      timestamp:  Time.at(post.time_in_episode).utc.strftime("%M:%S"),
      pops:       post.get_upvotes.size,
      comments:   comments

  end

  def find_comments(comment, post)
    post.comments.where("time_in_episode <= ?", comment.time_in_episode).includes(:user).map {|c|
      {comment_id:  c.id,
      content:      c.content,
      username:     c.user.screen_name,
      thumb_url:    c.user.avatar.thumb.url,
      timestamp:    Time.at(c.time_in_episode).utc.strftime("%M:%S")}}
  end
end
