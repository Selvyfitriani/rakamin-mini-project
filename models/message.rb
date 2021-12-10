class Message
  def initialize(sender, receiver, text, conversation, id = nil)
    @sender = sender
    @receiver = receiver
    @conversation = conversation
    @text = text
    @created_at = Time.now.strftime '%F %T'
    @status = 'UNREAD'
    @id = id
  end

  def valid?
    return false if @conversation.nil?
    return false unless @conversation.valid?
    return false unless valid_text?

    true
  end

  def valid_text?
    return false if @text.nil?

    !@text.empty? && @text.length <= 1000
  end

  def save
    false
  end
end
