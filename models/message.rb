require './database/db_connector'

class Message
  attr_accessor :sender, :receiver, :text, :created_at

  def initialize(sender, receiver, text, conversation, created_at = nil, status = nil, id = nil)
    @sender = sender
    @receiver = receiver
    @conversation = conversation
    @text = text
    @created_at = created_at
    @status = status
    @id = id
  end

  def valid?
    return false if @sender.nil?
    return false if @receiver.nil?
    return false if @conversation.nil?
    return false unless @conversation.valid?
    return false unless valid_text?

    true
  end

  def valid_text?
    return false if @text.nil?

    !@text.empty? && @text.length <= 1000
  end

  def self.find_all
    client = create_db_client
    raw_data = client.query('SELECT * FROM messages')

    Transform.to_messages(raw_data)
  end

  def save
    return false unless valid?

    client = create_db_client
    client.query('INSERT INTO messages' \
      '(sender_id, receiver_id, conversation_id, text) ' \
      "VALUES (#{@sender.id}, #{@receiver.id}, #{@conversation.id}, '#{@text}')")

    true
  end

  def self.last_insert_id
    client = create_db_client
    raw_data = client.query('SELECT MAX(id) as id FROM messages')

    Transform.to_id(raw_data)
  end

  def self.find_by_conversation_id(conversation_id)
    client = create_db_client
    raw_data = client.query('SELECT * FROM messages ' \
      "WHERE conversation_id=#{conversation_id}")

    Transform.to_messages(raw_data)
  end

  def self.find_by_conversations(conversations)
    list_messages = []

    conversations.each do |conversation|
      messages = Message.find_by_conversation_id(conversation.id)
      list_messages.push(messages)
    end

    list_messages
  end
end

