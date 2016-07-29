class CommentBroadcastWorker
  include Sidekiq::Worker

  def perform(new_comment_time_in_episode)
    post = comment.post

    comments = post.comments.where("time_in_episode <= ?", new_comment_time_in_episode).includes(:user).map {|c|
      {comment_id:  c.id,
      content:      c.content,
      username:     c.user.screen_name,
      thumb_url:    c.user.avatar.thumb.url,
      timestamp:    Time.at(c.time_in_episode).utc.strftime("%M:%S")}}

    ActionCable.server.broadcast "#{post.feed_id}",
      post_id:    post.id,
      content:    post.content,
      username:   post.user.screen_name,
      thumb_url:  post.user.avatar.thumb.url,
      timestamp:  Time.at(post.time_in_episode).utc.strftime("%M:%S"),
      pops:       post.get_upvotes.size,
      comments:   comments

  end
end
