require './controllers/conversation_controller'
require './models/message'

describe ConversationController do
  before(:each) do
    client = create_db_client
    client.query('SET FOREIGN_KEY_CHECKS = 0')
    client.query('TRUNCATE users')
    client.query('TRUNCATE conversations')
    client.query('TRUNCATE messages')
    client.query('SET FOREIGN_KEY_CHECKS = 1')
  end

  describe '#find_conversation' do
    context 'when there is conversation between 2 user' do
      it 'should return the conversation' do
        first_user = User.new('selvyfitriani31', 'Selvy Fitriani')
        first_user.save
        first_user_id = User.last_insert_id

        second_user = User.new('selvyfitriani32', 'Selvy')
        second_user.save
        second_user_id = User.last_insert_id

        message_params = {
          'sender_id' => first_user_id,
          'receiver_id' => second_user_id,
          'text' => 'Hi'
        }

        user_controller = UserController.new
        user_controller.send_message(message_params)

        params = {
          'first_user_id' => first_user_id,
          'second_user_id' => second_user_id,
        }

        conversation = Conversation.find_by_users_id(params['first_user_id'], params['second_user_id'])
        messages = Message.find_by_conversation_id(conversation.id)
        expect(messages.length).to eq(1)

        controller = ConversationController.new
        response = controller.find_conversation(params)
        expected_response = ERB.new(File.read('./views/success_find_conversation.erb')).result(binding)
        expect(response).to eq(expected_response)
      end
    end

    context 'when there is no conversation between 2 user' do
      it 'should return nil' do
        first_user = User.new('selvyfitriani31', 'Selvy Fitriani')
        first_user.save
        first_user_id = User.last_insert_id

        second_user = User.new('selvyfitriani32', 'Selvy')
        second_user.save
        second_user_id = User.last_insert_id

        params = {
          'first_user_id' => first_user_id,
          'second_user_id' => second_user_id,
        }

        controller = ConversationController.new
        response = controller.find_conversation(params)
        expected_response = ERB.new(File.read('./views/failed_find_conversation.erb')).result(binding)
        expect(response).to eq(expected_response)
      end
    end
  end
end
