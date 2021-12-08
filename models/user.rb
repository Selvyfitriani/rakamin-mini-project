class User
  def initialize(username:, name:)
    @username = username
    @name = name
  end

  def valid?
    true
  end
end
