require './models/message'
require './models/user'
require './models/conversation'

class MessageController
  def create(params)
    if params['sender_id'].nil? || params['receiver_id'].nil? ||
        params['conversation_id'].nil? || params['text'].nil?

      return nil
    end

    sender = User.find_by_id(params['sender_id'])
    receiver = User.find_by_id(params['receiver_id'])
    conversation = Conversation.find_by_id(params['conversation_id'])
    text = params['text']

    message = Message.new(sender, receiver, text, conversation)
    message.save
  end
end
