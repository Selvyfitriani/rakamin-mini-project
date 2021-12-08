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
  end
end
