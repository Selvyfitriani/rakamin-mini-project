require 'spec_helper'
require 'test_helper'
require './database/db_connector'
require './controllers/user_controller'

describe UserController do
  before(:each) do
    client = create_db_client
    client.query('SET FOREIGN_KEY_CHECKS = 0')
    client.query('TRUNCATE users')
    client.query('TRUNCATE conversations')
    client.query('TRUNCATE messages')
    client.query('SET FOREIGN_KEY_CHECKS = 1')
  end

  describe '#send_message' do
    context 'when user want to send invalid message' do
      it 'should return error message' do
        params = {}

        controller = UserController.new
        response = controller.send_message(params)
        expected_response = ERB.new(File.read('./views/failed_send_message.erb')).result(binding)

        expect(response).to eq(expected_response)
      end
    end

    context 'when user want to send valid message' do
      it 'should send message to another user' do
        sender = User.new('selvyfitriani31', 'Selvy Fitriani')
        sender.save
        sender_id = User.last_insert_id
        sender = User.find_by_id(sender_id)

        receiver = User.new('selvyfitriani32', 'Selvy')
        receiver.save
        receiver_id = User.last_insert_id
        receiver = User.find_by_id(receiver_id)

        conversation = Conversation.new(sender, receiver)
        conversation.save
        conversation_id = Conversation.last_insert_id

        params = {
          'sender_id' => sender_id,
          'receiver_id' => receiver_id,
          'conversation_id' => conversation_id,
          'text' => 'Hi'
        }

        controller = UserController.new
        response = controller.send_message(params)

        message_id = Message.last_insert_id
        expect(message_id).not_to be(nil)

        expected_response = ERB.new(File.read('./views/success_send_message.erb')).result(binding)
        expect(response).to eq(expected_response)
      end
    end
  end
end
