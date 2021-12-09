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
end
