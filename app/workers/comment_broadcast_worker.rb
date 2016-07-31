class CommentBroadcastWorker
  include Sidekiq::Worker

  def perform(comment_id, feed_id = nil)
    comment = Comment.find comment_id
    post = comment.post

    unless feed_id.present?
      feed_id = comment.feed_id
    end

    if post.time_in_episode < 0
      post_timestamp = "-#{(Time.at(-(post.time_in_episode)).utc.strftime("%M:%S"))}"
    else
      post_timestamp = Time.at(post.time_in_episode).utc.strftime("%M:%S")
    end

    comments = find_comments(comment, post)

    ActionCable.server.broadcast "#{feed_id}",
      post_id:    post.id,
      content:    post.content,
      username:   post.user.screen_name,
      thumb_url:  post.user.avatar.thumb.url,
      timestamp:  post_timestamp,
      pops:       post.get_upvotes.size,
      comments:   comments

  end

  def find_comments(comment, post)
    post.comments.where("time_in_episode <= ?", comment.time_in_episode).includes(:user).map {|c|
      {comment_id:  c.id,
      content:      c.content,
      username:     c.user.screen_name,
      thumb_url:    c.user.avatar.thumb.url,
      timestamp:    comment_time_in_episode(c)}}.reverse
  end

  def comment_time_in_episode(comment)
    if comment.time_in_episode < 0
      "-#{(Time.at(-(comment.time_in_episode)).utc.strftime("%M:%S"))}"
    else
      Time.at(comment.time_in_episode).utc.strftime("%M:%S")
    end
  end
end
