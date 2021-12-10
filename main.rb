require 'sinatra'
require './controllers/user_controller'

post '/users/send-message' do
  controller = UserController.new
  controller.send_message(params)
end
