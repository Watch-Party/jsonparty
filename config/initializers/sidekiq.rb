require 'sidekiq'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"] }
  config.average_scheduled_poll_interval = 3
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"] }
end
