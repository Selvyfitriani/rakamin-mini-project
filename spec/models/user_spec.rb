
require 'spec_helper'
require 'test_helper'
require './database/db_connector'
require './models/user'

describe User do
  before(:each) do
    client = create_db_client
    client.query('SET FOREIGN_KEY_CHECKS = 0')
    client.query('TRUNCATE users')
    client.query('SET FOREIGN_KEY_CHECKS = 1')
  end

  describe '#valid?' do
    context 'when initialize valid user' do
      it 'should return true' do
        user = User.new('selvyfitriani31', 'Selvy Fitriani')

        expect(user.valid?).to eq(true)
      end
    end

    context 'when initialize user with nil username' do
      it 'should return false' do
        user = User.new(nil, 'Selvy Fitriani')

        expect(user.valid?).to eq(false)
      end
    end

    context 'when initialize user with empty username' do
      it 'should return false' do
        user = User.new('', 'Selvy Fitriani')

        expect(user.valid?).to eq(false)
      end
    end

    context 'when initialize user with username length is out of bounds' do
      it 'should return false' do
        user = User.new('s' * 31, 'Selvy Fitriani')

        expect(user.valid?).to eq(false)
      end
    end

    context 'when initialize user with nil name' do
      it 'should return false' do
        user = User.new('selvyfitriani31', nil)

        expect(user.valid?).to eq(false)
      end
    end

    context 'when initialize user with empty name' do
      it 'should return false' do
        user = User.new('selvyfitriani31', '')

        expect(user.valid?).to eq(false)
      end
    end

    context 'when initialize user with name length is out of bounds' do
      it 'should return false' do
        user = User.new('selvyfitriani31', 's' * 51)

        expect(user.valid?).to eq(false)
      end
    end
  end

  describe '#save' do
    context 'when save invalid user' do
      it 'should return false' do
        user = User.new('', '')

        expect(user.save).to eq(false)
      end
    end

    context 'when save valid user' do
      it 'should save user to database' do
        user = User.new('selvyfitriani31', 'Selvy Fitriani')
        user.save

        expect(User.find_all.length).to eq(1)
      end
    end

    context 'when save duplicate username' do
      it 'should return false' do
        user_one = User.new('selvyfitriani31', 'Selvy Fitriani')
        user_two = User.new('selvyfitriani31', 'Selvy')

        user_one.save

        expect(user_two.save).to eq(false)
      end
    end
  end

  describe 'find_by_id' do
    context 'when user is not found' do
      it 'should return nil' do
        user = User.find_by_id(1)

        expect(user).to be(nil)
      end
    end

    context 'when user is found' do
      it 'should return not nil' do
        user = User.new('selvyfitriani31', 'Selvy Fitriani')
        user.save

        id = User.last_insert_id
        searched_user = User.find_by_id(id)

        expect(searched_user).not_to be(nil)
      end
    end
  end
end
