unless Rails.env.production?
  bot_files = Dir[Rails.root.join('app', 'bot_incoming', '**', '*.rb')]
  bots_reloader = ActiveSupport::FileUpdateChecker.new(bot_files) do
    bot_files.each{ |file| require_dependency file }
  end

  ActionDispatch::Callbacks.to_prepare do
    bots_reloader.execute_if_updated
  end

  bot_files.each { |file| require_dependency file }
end

Facebook::Messenger.configure do |config|
  config.access_token = Figaro.env.fb_access_token
  config.app_secret = Figaro.env.fb_app_secret
  config.verify_token = Figaro.env.fb_verify_token
end

Facebook::Messenger::Subscriptions.subscribe
