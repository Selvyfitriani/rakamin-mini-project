require './models/user'

class Conversation
  def initialize(first_user:, second_user:)
    @first_user = first_user
    @second_user = second_user
  end

  def valid?
    valid_user?(@first_user)
  end

  def valid_user?(user)
    return false if user.nil?

    searched_user = User.find_by_username(user.username)
    return false if searched_user.nil?

    true
  end
end
