class DelayedFeed

  #service object that queues up comments and posts for delayed channels
  def initialize feed, viewtype, user
    @feed = feed
    @viewtype = viewtype
    @user = user
  end

  #called when a delayed channel is connected to
  def start
    #viewtype all queues all posts for an episode
    #else only posts from friends/watched are queued
    if @viewtype == "all"
      posts = @feed.episode.posts.where('posts.time_in_episode > ?', 0)
      comments = @feed.episode.comments.where('comments.time_in_episode > ?', 0)
    else
      posts = @feed.episode.posts.where('posts.time_in_episode > ?', 0).includes(:user)
      comments = @feed.episode.comments.where('comments.time_in_episode > ?', 0).includes(:user)

      watched = @user.watched

      posts = posts.select {|p| watched.include?(p.user)}
      comments = comments.select {|c| watched.include?(c.user)}
    end

    #queue up posts to be broadcast at correct time in episode
    posts.each do |post|
      PostBroadcastWorker.perform_in(
                                (post.time_in_episode.to_i).seconds,
                                 post.id,
                                 @feed.id
                                 )
    end

    #queue up comments to be broadcast at correct time in episode
    comments.each do |comment|
      CommentBroadcastWorker.perform_in(
                                (comment.time_in_episode.to_i).seconds,
                                 comment.id,
                                 @feed.id
                                 )
    end
  end

end
