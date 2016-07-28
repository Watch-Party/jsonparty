class DelayedFeed

  def initialize feed
    @feed = feed
  end

  def start
    @feed.episode.posts.each do |post|
      PostBroadcastWorker.perform_in(
                                (post.time_in_episode.to_i - @feed.start_time.to_i).seconds,
                                 post.id
                                 )
    end
  end

end
