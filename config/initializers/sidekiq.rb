if Rails.env.production?
  redis = { host: ENV["REDIS_URL"] }

  Sidekiq.configure_client do |config|
    config.redis = redis
  end

  Sidekiq.configure_server do |config|
    config.redis = redis
    config.logger = Sidekiq::Logger.new($stdout)
  end
end