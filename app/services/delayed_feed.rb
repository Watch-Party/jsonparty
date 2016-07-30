class DelayedFeed

  def initialize feed, viewtype, user
    @feed = feed
    @viewtype = viewtype
    @user = user
  end

  def start
    if @viewtype == "all"
      posts = @feed.episode.posts
      comments = @feed.episode.comments
    else
      posts = @feed.episode.posts.includes(:user)
      comments = @feed.episode.comments.includes(:user)

      watched = @user.watched

      posts = posts.select {|p| watched.include?(p.user)}
      comments = comments.select {|c| watched.include?(c.user)}
    end

    posts.each do |post|
      PostBroadcastWorker.perform_in(
                                (post.time_in_episode.to_i).seconds,
                                 post.id,
                                 @feed.id
                                 )
    end

    comments.each do |comment|
      CommentBroadcastWorker.perform_in(
                                (comment.time_in_episode.to_i).seconds,
                                 comment.id,
                                 @feed.id
                                 )
    end
  end

end
