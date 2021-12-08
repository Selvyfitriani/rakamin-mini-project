
require 'spec_helper'
require 'test_helper'
require './database/db_connector'
require './models/user'

describe User do
  before(:each) do
    client = create_db_client
    client.query('TRUNCATE users')
  end

  describe '#valid?' do
    context 'when initialize valid user' do
      it 'should return true' do
        user = User.new(username: 'selvyfitriani31', name: 'Selvy Fitriani')

        expect(user.valid?).to eq(true)
      end
    end

    context 'when initialize user without username' do
      it 'should return false' do
        user = User.new(username: '', name: 'Selvy Fitriani')

        expect(user.valid?).to eq(false)
      end
    end

    context 'when initialize user with username length is out of bounds' do
      it 'should return false' do
        user = User.new(username: 's' * 31, name: 'Selvy Fitriani')

        expect(user.valid?).to eq(false)
      end
    end

    context 'when initialize user with empty name' do
      it 'should return false' do
        user = User.new(username: 'selvyfitriani31', name: '')

        expect(user.valid?).to eq(false)
      end
    end

    context 'when initialize user with name length is out of bounds' do
      it 'should return false' do
        user = User.new(username: 'selvyfitriani31', name: 's' * 51)

        expect(user.valid?).to eq(false)
      end
    end
  end

  describe '#save' do
    context 'when save invalid user' do
      it 'should return false' do
        user = User.new(username: '', name: '')

        expect(user.save).to eq(false)
      end
    end

    context 'when save valid user' do
      it 'should save user to database' do
        user = User.new(username: 'selvyfitriani31', name: 'Selvy Fitriani')

        dummy_db = double
        allow(Mysql2::Client).to receive(:new).and_return(dummy_db)

        expect(dummy_db).to receive(:query).with('SELECT * FROM users ' \
          "WHERE username='#{user.username}'")
        expect(dummy_db).to receive(:query).with('INSERT INTO users (username, name) ' \
          "VALUES ('#{user.username}', '#{user.name}')")

        user.save
      end
    end

    context 'when save duplicate username' do
      it 'should return false' do
        user_one = User.new(username: 'selvyfitriani31', name: 'Selvy Fitriani')
        user_two = User.new(username: 'selvyfitriani31', name: 'Selvy')

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
  end
end
