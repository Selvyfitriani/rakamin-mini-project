require 'spec_helper'
require 'test_helper'
require './database/db_connector'
require './models/user'

describe User do
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

        expect(dummy_db).to receive(:query).with('INSERT INTO users (username, name) ' \
          "VALUES ('#{user.username}', '#{user.name}')")

        user.save
      end
    end
  end
end
