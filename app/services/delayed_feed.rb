class DelayedFeed

  def initialize feed, viewtype, user
    @feed = feed
    @viewtype = viewtype
    @user = user
  end

  def start
    if @viewtype == "all"
      posts = @feed.episode.posts
    else
      posts = @feed.episode.posts.includes(:user)
      watched = @user.watched
      posts = posts.select {|p| watched.include?(p.user)}
    end

    posts.each do |post|
      PostBroadcastWorker.perform_in(
                                (post.time_in_episode.to_i - @feed.start_time.to_i).seconds,
                                 post.id
                                 )
    end
  end

end
