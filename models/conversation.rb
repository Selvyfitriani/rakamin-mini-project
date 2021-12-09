require './models/user'

class Conversation
  def initialize(first_user:, second_user:)
    @first_user = first_user
    @second_user = second_user
  end

  def valid?
    return false if @first_user == @second_user

    valid_user?(@first_user) && valid_user?(@second_user)
  end

  def valid_user?(user)
    return false if user.nil?

    searched_user = User.find_by_username(user.username)
    return false if searched_user.nil?

    true
  end

  def save
    false
  end
end
