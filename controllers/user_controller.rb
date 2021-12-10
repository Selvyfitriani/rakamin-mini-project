class UserController 
  def send_message(params)
    rendered = ERB.new(File.read('./views/failed_send_message.erb'))

    rendered.result(binding)
  end
end
