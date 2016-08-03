class WelcomeMessageWorker
  include Sidekiq::Worker

  def perform(feed_id)
    feed = Feed.find(feed_id)
    ActionCable.server.broadcast "#{feed.id}",
      feed_name:  feed.name,
      post_id:    42,
      content:    "Welcome to '#{feed.name}'",
      username:   "Watch Party",
      thumb_url:  "https://s3.amazonaws.com/watch-party/uploads/user/avatar/6/thumb_watchparty.jpg",
      timestamp:  "--:--",
      pops:       42

  end

end
