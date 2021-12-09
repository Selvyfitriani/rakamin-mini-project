require './models/message'
require './models/conversation'

describe Message do
  describe '#valid?' do
    context 'when initialize valid message' do
      it 'should return true' do
        sender = User.new(username: 'selvyfitriani31', name: 'Selvy Fitriani')
        sender.save
        receiver = User.new(username: 'selvyfitriani32', name: 'Selvy')
        receiver.save
        conversation = Conversation.new(first_user: sender, second_user: receiver)
        text = 'Hai'

        message = Message.new(sender: sender, receiver: receiver, text: text, conversation: conversation)

        expect(message.valid?).to be(true)
      end
    end

    context 'when initialize message with invalid conversation' do
      it 'should return false' do
        sender = User.new(username: 'selvyfitriani31', name: 'Selvy Fitriani')
        conversation = Conversation.new(first_user: sender, second_user: nil)
        text = 'Hai'

        message = Message.new(sender: sender, receiver: nil, text: text, conversation: conversation)

        expect(message.valid?).to be(false)
      end
    end
  end
end
