class Message
  def initialize(sender:, receiver:, text:, conversation:)
    @sender = sender
    @receiver = receiver
    @conversation = conversation
  end

  def valid?
    return false unless @conversation.valid?

    true
  end
end
