class User

  attr_accessor :username, :name

  def initialize(username:, name:)
    @username = username
    @name = name
  end

  def valid?
    return false unless valid_username?
    return false unless valid_name?

    true
  end

  def valid_username?
    !@username.empty? && @username.length <= 30
  end

  def valid_name?
    !@name.empty? && @name.length <= 50
  end

  def save
    return false unless valid?

    client = create_db_client

    client.query("INSERT INTO users (username, name) VALUES ('#{@username}', '#{@name}')")
  end
end
