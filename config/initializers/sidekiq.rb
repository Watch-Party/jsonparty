require 'sidekiq'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDISTOGO_URL"] }
  config.average_scheduled_poll_interval = 1
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDISTOGO_URL"] }
end
