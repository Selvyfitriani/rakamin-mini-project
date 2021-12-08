class User
  def initialize(username:, name:)
    @username = username
    @name = name
  end

  def valid?
    return false unless valid_username?

    true
  end

  def valid_username?
    !@username.empty? && @username.length <= 30
  end
end
