Rails.application.routes.draw do
  mount Facebook::Messenger::Server, at: 'bot_incoming/facebook'
end
