class WelcomeMessageWorker

  def perform(feed_id)
    feed = Feed.find(42)
    ActionCable.server.broadcast "#{feed.id}",
      feed_name:  feed.name,
      post_id:    42,
      content:    "Welcome to '#{feed.name}'",
      username:   "Watch Party",
      thumb_url:  "https://s3.amazonaws.com/watch-party/uploads/user/avatar/6/thumb_watchparty.jpg",
      timestamp:  Time.at(Time.now - feed.start_time).utc.strftime("%M:%S"),
      pops:       42

  end

end
