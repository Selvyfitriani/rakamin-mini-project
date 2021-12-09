class Conversation
  def initialize(first_user:, second_user:)
    @first_user = first_user
    @second_user = second_user
  end

  def valid? 
    return true
  end
end
