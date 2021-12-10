require './controllers/message_controller'

class UserController 
  def send_message(params)
    message_controller = MessageController.new
    is_success = message_controller.create(params)
   
    rendered =
      if is_success
        ERB.new(File.read('./views/success_send_message.erb'))
      else
        ERB.new(File.read('./views/failed_send_message.erb'))
      end

    rendered.result(binding)
  end
end
