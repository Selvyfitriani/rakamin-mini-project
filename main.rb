require 'sinatra'
require './controllers/user_controller'
require './controllers/conversation_controller'

post '/users/send-message' do
  controller = UserController.new
  controller.send_message(params)
end

get '/users/find-conversation' do
  controller = ConversationController.new
  controller.find_conversation(params)
end

post '/users/reply' do
  controller = UserController.new
  controller.send_message(params)
end
