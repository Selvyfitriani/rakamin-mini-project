require './models/user'

class Conversation
  def initialize(first_user, second_user, id = nil)
    @first_user = first_user
    @second_user = second_user
    @id = id
  end

  def valid?
    return false if @first_user == @second_user

    valid_user?
  end

  def valid_user?
    return false if @first_user.nil?
    return false if @second_user.nil?

    searched_first_user = User.find_by_username(@first_user.username)
    searched_second_user = User.find_by_username(@second_user.username)

    return false if searched_first_user.nil?
    return false if searched_second_user.nil?

    true
  end

  def save
    false
  end
end
