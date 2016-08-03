class WelcomeMessageWorker
  include Sidekiq::Worker

  #worker object that sends a consistent welcome message when joining any channel
  def perform(feed_id)

    #find the feed
    feed = Feed.find(feed_id)

    #post_id 42 belongs to the offical watch party account
    #thumb_url is for the temporary app logo
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
