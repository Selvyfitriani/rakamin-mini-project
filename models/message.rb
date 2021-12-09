class Message
  def initialize(sender:, receiver:, text:, conversation:)
    @sender = sender
    @receiver = receiver
    @conversation = conversation
    @text = text
  end

  def valid?
    return false unless @conversation.valid?
    return false unless valid_text?

    true
  end

  def valid_text?
    return false if @text.nil?

    !@text.empty? && @text.length <= 1000
  end
end
