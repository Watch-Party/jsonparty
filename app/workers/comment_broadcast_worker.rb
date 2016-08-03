class CommentBroadcastWorker
  include Sidekiq::Worker

  #worker object that broadcasts a post and all comments (based on time of episode) for a comment just made
  def perform(comment_id, feed_id = nil)

    #find the comment, and the post it belongs to
    comment = Comment.find comment_id
    post = comment.post

    #check to see if broadcast is going to comments parent feed, or a delayed/party feed
    unless feed_id.present?
      feed_id = comment.feed_id
    end

    #broadcast
    ActionCable.server.broadcast "#{feed_id}",
      feed_name:  post.feed.name,
      post_id:    post.id,
      content:    post.content,
      username:   post.user.screen_name,
      thumb_url:  post.user.avatar.thumb.url,
      timestamp:  time_in_episode(post),
      pops:       post.cached_votes_total,
      comments:   find_comments(comment, post)

  end

  #finds comments for the parent post, but only returns comments from at or before the time of the current comment
  def find_comments(comment, post)
    post.comments.where("time_in_episode <= ?", comment.time_in_episode).order(:time_in_episode).includes(:user).map {|c|
      {comment_id:  c.id,
      content:      c.content,
      username:     c.user.screen_name,
      thumb_url:    c.user.avatar.thumb.url,
      timestamp:    time_in_episode(c)}}
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
