require './models/user'

class Transform
  def self.to_user(raw_data)
    return nil if raw_data.nil?

    user = nil
    raw_data.each do |datum|
      user = User.new(datum['username'], datum['name'], datum['id'])
    end

    user
  end

  def self.to_users(raw_data)
    return nil if raw_data.nil?

    users = []
    raw_data.each do |datum|
      user = User.new(datum['username'], datum['name'], datum['id'])

      users.push(user)
    end

    users
  end

  def self.to_id(raw_data)
    return nil if raw_data.nil?
    
    id = 0
    raw_data.each do |datum|
      id = datum['id'].to_i
    end

    id
  end

  def self.to_conversations(raw_data)
    conversations = []

    raw_data.each do |datum|
      first_user = User.find_by_id(datum['first_user_id'])
      second_user = User.find_by_id(datum['second_user_id'])

      conversation = Conversation.new(first_user, second_user, datum['id'])
      conversations.push(conversation)
    end

    conversations
  end

  def self.to_conversation(raw_data)
    return nil if raw_data.nil?

    conversation = nil
    raw_data.each do |datum|
      first_user = User.find_by_id(datum['first_user_id'])
      second_user = User.find_by_id(datum['second_user_id'])

      conversation = Conversation.new(first_user, second_user, datum['id'])
    end

    conversation
  end

  def self.to_messages(raw_data)
    messages = []

    raw_data.each do |datum|
      sender = User.find_by_id(datum['sender_id'])
      receiver = User.find_by_id(datum['receiver_id'])
      conversation = Conversation.find_by_id(datum['conversation_id'])
      text = datum['text']
      created_at = datum['created_at']
      status = datum['status']
      id = datum['id']

      message = Message.new(sender, receiver, text, conversation, created_at, status, id)
      messages.push(message)
    end

    messages
  end
end
