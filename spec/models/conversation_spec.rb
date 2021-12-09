require 'spec_helper'
require 'test_helper'
require './models/conversation'

describe Conversation do
  before(:each) do
    client = create_db_client
    client.query('SET FOREIGN_KEY_CHECKS = 0')
    client.query('TRUNCATE users')
    client.query('SET FOREIGN_KEY_CHECKS = 1')
  end

  describe '#valid?' do
    context 'when initialize valid conversation' do
      it 'should return true' do
        first_user = User.new(username: 'selvyfitriani31', name: 'Selvy Fitriani')
        second_user = User.new(username: 'selvyfitriani32', name: 'Selvy')
        first_user.save
        second_user.save

        conversation = Conversation.new(first_user: first_user, second_user: second_user)

        expect(conversation.valid?).to be(true)
      end
    end
  end
end
