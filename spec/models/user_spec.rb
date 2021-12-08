require 'spec_helper'
require 'test_helper'
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
  end
end
