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
    return false if @username.nil?

    !@username.empty? && @username.length <= 30
  end

  def valid_name?
    return false if @name.nil?

    !@name.empty? && @name.length <= 50
  end

  def duplicate_username?
    user = User.find_by_username(@username)

    !user.nil?
  end

  def save
    return false unless valid?

    if duplicate_username?
      return false
    end

    client = create_db_client

    client.query("INSERT INTO users (username, name) VALUES ('#{@username}', '#{@name}')")
  end

  def self.find_by_id(id)
    client = create_db_client
    raw_data = client.query("SELECT * FROM users WHERE id=#{id}")

    user = nil
    raw_data.each do |datum|
      user = User.new(username: datum['username'], name: datum['name'])
    end

    user
  end

  def self.find_by_username(username)
    client = create_db_client
    raw_data = client.query("SELECT * FROM users WHERE username='#{username}'")

    return nil if raw_data.nil?

    user = nil
    raw_data.each do |datum|
      user = User.new(username: datum['username'], name: datum['name'])
    end

    user
  end

  def self.last_insert_id
    client = create_db_client
    raw_data = client.query('SELECT MAX(id) as id FROM users')

    id = 0
    raw_data.each do |datum|
      id = datum['id'].to_i
    end

    id
  end
end
