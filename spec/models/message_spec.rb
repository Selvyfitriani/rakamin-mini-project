require './models/message'
require './models/conversation'

describe Message do
  describe '#valid?' do
    context 'when initialize valid message' do
      it 'should return true' do
        sender = User.new('selvyfitriani31', 'Selvy Fitriani')
        sender.save
        receiver = User.new('selvyfitriani32', 'Selvy')
        receiver.save
        conversation = Conversation.new(first_user: sender, second_user: receiver)
        text = 'Hai'

        message = Message.new(sender: sender, receiver: receiver, text: text, conversation: conversation)

        expect(message.valid?).to be(true)
      end
    end

    context 'when initialize message with invalid conversation' do
      it 'should return false' do
        sender = User.new('selvyfitriani31', 'Selvy Fitriani')
        conversation = Conversation.new(first_user: sender, second_user: nil)
        text = 'Hai'

        message = Message.new(sender: sender, receiver: nil, text: text, conversation: conversation)

        expect(message.valid?).to be(false)
      end
    end

    context 'when intialize message with empty text' do
      it 'should return false' do
        sender = User.new('selvyfitriani31', 'Selvy Fitriani')
        sender.save
        receiver = User.new('selvyfitriani32', 'Selvy')
        receiver.save
        conversation = Conversation.new(first_user: sender, second_user: receiver)
        text = ''

        message = Message.new(sender: sender, receiver: receiver, text: text, conversation: conversation)

        expect(message.valid?).to be(false)
      end
    end

    context 'when intialize message with nil text' do
      it 'should return false' do
        sender = User.new('selvyfitriani31', 'Selvy Fitriani')
        sender.save
        receiver = User.new('selvyfitriani32', 'Selvy')
        receiver.save
        conversation = Conversation.new(first_user: sender, second_user: receiver)
        text = nil

        message = Message.new(sender: sender, receiver: receiver, text: text, conversation: conversation)

        expect(message.valid?).to be(false)
      end
    end

    context 'when intialize message with out of bounds text length' do
      it 'should return false' do
        sender = User.new('selvyfitriani31', 'Selvy Fitriani')
        sender.save
        receiver = User.new('selvyfitriani32', 'Selvy')
        receiver.save
        conversation = Conversation.new(first_user: sender, second_user: receiver)
        text = 'S' * 1001

        message = Message.new(sender: sender, receiver: receiver, text: text, conversation: conversation)

        expect(message.valid?).to be(false)
      end
    end
  end

  describe '#save' do
    context 'when save invalid message' do
      it 'should return false' do
        message = Message.new(sender: nil, receiver: nil, text: nil, conversation: nil)

        expect(message.save).to be(false)
      end
    end
  end
end
