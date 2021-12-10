require './controllers/user_controller'

describe UserController do
  describe '#send_message' do
    context 'when user want to send invalid message' do
      it 'should return error message' do
        message = Message.new(nil, nil, nil, nil)

        controller = UserController.new
        response = controller.send_message(message)
        expected_response = ERB.new(File.read('./views/failed_send_message.erb')).result(binding)

        expect(response).to eq(expected_response)
      end
    end
  end
end
