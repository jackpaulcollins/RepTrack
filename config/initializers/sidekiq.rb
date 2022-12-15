Sidekiq.configure_server do |config|
    config.logger.level = Rails.logger.debug
  end