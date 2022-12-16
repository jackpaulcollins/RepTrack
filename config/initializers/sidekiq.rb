Sidekiq.configure_server do |config|
  config.logger = Sidekiq::Logger.new($stdout)
end

if Rails.env.production?
  Sidekiq.configure_client do |config|
    config.redis = { host: ENV["REDIS_URL"] }
  end
end