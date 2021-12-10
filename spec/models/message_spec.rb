require './models/message'
require './models/conversation'

describe Message do
  before(:each) do
    client = create_db_client
    client.query('SET FOREIGN_KEY_CHECKS = 0')
    client.query('TRUNCATE users')
    client.query('TRUNCATE conversations')
    client.query('TRUNCATE messages')
    client.query('SET FOREIGN_KEY_CHECKS = 1')
  end

  describe '#valid?' do
    context 'when initialize valid message' do
      it 'should return true' do
        sender = User.new('selvyfitriani31', 'Selvy Fitriani')
        sender.save
        receiver = User.new('selvyfitriani32', 'Selvy')
        receiver.save
        conversation = Conversation.new(sender, receiver)
        text = 'Hai'

        message = Message.new(sender, receiver, text, conversation)

        expect(message.valid?).to be(true)
      end
    end

    context 'when initialize message with invalid conversation' do
      it 'should return false' do
        sender = User.new('selvyfitriani31', 'Selvy Fitriani')
        conversation = Conversation.new(sender, nil)
        text = 'Hai'

        message = Message.new(sender, nil, text, conversation)

        expect(message.valid?).to be(false)
      end
    end

    context 'when initialize message with nil conversation' do
      it 'should return false' do
        sender = User.new('selvyfitriani31', 'Selvy Fitriani')
        sender.save
        receiver = User.new('selvyfitriani32', 'Selvy')
        receiver.save

        text = 'Hai'

        message = Message.new(sender, receiver, text, nil)

        expect(message.valid?).to be(false)
      end
    end

    context 'when intialize message with empty text' do
      it 'should return false' do
        sender = User.new('selvyfitriani31', 'Selvy Fitriani')
        sender.save
        receiver = User.new('selvyfitriani32', 'Selvy')
        receiver.save
        conversation = Conversation.new(sender, receiver)
        text = ''

        message = Message.new(sender, receiver, text, conversation)

        expect(message.valid?).to be(false)
      end
    end

    context 'when intialize message with nil text' do
      it 'should return false' do
        sender = User.new('selvyfitriani31', 'Selvy Fitriani')
        sender.save
        receiver = User.new('selvyfitriani32', 'Selvy')
        receiver.save
        conversation = Conversation.new(sender, receiver)
        text = nil

        message = Message.new(sender, receiver, text, conversation)

        expect(message.valid?).to be(false)
      end
    end

    context 'when intialize message with out of bounds text length' do
      it 'should return false' do
        sender = User.new('selvyfitriani31', 'Selvy Fitriani')
        sender.save
        receiver = User.new('selvyfitriani32', 'Selvy')
        receiver.save
        conversation = Conversation.new(sender, receiver)
        text = 'S' * 1001

        message = Message.new(sender, receiver, text, conversation)

        expect(message.valid?).to be(false)
      end
    end
  end

  describe '#save' do
    context 'when save invalid message' do
      it 'should return false' do
        message = Message.new(nil, nil, nil, nil)

        expect(message.save).to be(false)
      end
    end

    context 'when save valid message' do
      it 'should save message to database' do
        sender = User.new('selvyfitriani31', 'Selvy Fitriani')
        sender.save
        sender = User.find_by_username(sender.username)

        receiver = User.new('selvyfitriani32', 'Selvy')
        receiver.save
        receiver = User.find_by_username(receiver.username)

        conversation = Conversation.new(sender, receiver)
        conversation.save
        conversation_id = Conversation.last_insert_id
        conversation = Conversation.find_by_id(conversation_id)

        text = 'Hai'

        message = Message.new(sender, receiver, text, conversation)
        message.save

        expect(Message.find_all.length).to eq(1)
      end
    end
  end
end
