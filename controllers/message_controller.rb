require './models/message'
require './models/user'
require './models/conversation'

class MessageController
  def create(params)
    if params['sender_id'].nil? || params['receiver_id'].nil? || params['text'].nil?
      return false
    end

    conversation = Conversation.find_by_users_id(params['sender_id'], params['receiver_id'])
    sender = User.find_by_id(params['sender_id'])
    receiver = User.find_by_id(params['receiver_id'])
    text = params['text']

    if conversation.nil?
      if sender.nil? || receiver.nil?
        return false
      else
        conversation = Conversation.new(sender, receiver)
        conversation.save
       
        conversation_id = Conversation.last_insert_id
        conversation = Conversation.find_by_id(conversation_id)
      end
    end

    message = Message.new(sender, receiver, text, conversation)
    message.save
  end
end
