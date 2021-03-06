require './models/conversation'
require './models/message'

class ConversationController
  def find_conversation(params)
    response = nil
    if params['first_user_id'].nil? || params['second_user_id'].nil?
      response = ERB.new(File.read('./views/failed_find_conversation.erb'))
    else
      conversation = Conversation.find_by_users_id(params['first_user_id'], params['second_user_id'])
      if conversation.nil?
        response = ERB.new(File.read('./views/failed_find_conversation.erb'))
      else
        messages = Message.find_by_conversation_id(conversation.id)
        response = ERB.new(File.read('./views/success_find_conversation.erb'))
      end
    end

    response.result(binding)
  end

  def find_all_conversation(params)
    response = nil
    list_messages = nil
    
    if params['user_id'].nil?
      response = ERB.new(File.read('./views/failed_find_all_conversation.erb'))
    else
      conversations = Conversation.find_all_by_user_id(params['user_id'])

      if conversations == []
        response = ERB.new(File.read('./views/failed_find_all_conversation.erb'))
      else
        list_messages = Message.find_by_conversations(conversations)
        response = ERB.new(File.read('./views/success_find_all_conversation.erb'))
      end
    end
    response.result(binding)
  end
end
