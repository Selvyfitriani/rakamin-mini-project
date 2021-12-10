require './models/conversation'
require './models/message'

class ConversationController
  def find_conversation(params)
    conversation = Conversation.find_by_users_id(params['first_user_id'], params['second_user_id'])

    messages = Message.find_by_conversation_id(conversation.id)

    response = ERB.new(File.read('./views/success_find_conversation.erb'))

    response.result(binding)
  end
end
