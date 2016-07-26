Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redistogo:7eb0545f6b8f9d2e59fe908164890fac@catfish.redistogo.com:10336/' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redistogo:7eb0545f6b8f9d2e59fe908164890fac@catfish.redistogo.com:10336/' }
end
