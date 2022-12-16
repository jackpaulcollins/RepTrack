Sidekiq.configure_server do |config|
  config.logger = Sidekiq::Logger.new($stdout)
end

Sidekiq.configure_client do |config|
  config.redis = ENV["REDIS_URL"]
end