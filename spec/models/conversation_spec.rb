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
        first_user = User.new('selvyfitriani31', 'Selvy Fitriani')
        second_user = User.new('selvyfitriani32', 'Selvy')
        first_user.save
        second_user.save

        conversation = Conversation.new(first_user: first_user, second_user: second_user)

        expect(conversation.valid?).to be(true)
      end
    end

    context 'when initialize conversation without first user' do
      it 'should return false' do
        second_user = User.new('selvyfitriani32', 'Selvy')
        second_user.save

        conversation = Conversation.new(first_user: nil, second_user: second_user)

        expect(conversation.valid?).to be(false)
      end
    end

    context 'when initialize conversation with non-exist first user in database' do
      it 'should return false' do
        first_user = User.new('selvyfitriani31', 'Selvy Fitriani')
        second_user = User.new('selvyfitriani32', 'Selvy')
        second_user.save

        conversation = Conversation.new(first_user: first_user, second_user: second_user)

        expect(conversation.valid?).to be(false)
      end
    end

    context 'when initialize conversation without second user' do
      it 'should return false' do
        first_user = User.new('selvyfitriani32', 'Selvy')
        first_user.save

        conversation = Conversation.new(first_user: first_user, second_user: nil)

        expect(conversation.valid?).to be(false)
      end
    end

    context 'when initialize with twin users' do
      it 'should return false' do
        user = User.new('selvyfitriani32', 'Selvy')
        user.save

        conversation = Conversation.new(first_user: user, second_user: user)

        expect(conversation.valid?).to be(false)
      end
    end
  end

  describe '#save' do
    context 'when save invalid conversation' do
      it 'should return false' do
        conversation = Conversation.new(first_user: nil, second_user: nil)

        expect(conversation.save).to be(false)
      end
    end
  end
end
