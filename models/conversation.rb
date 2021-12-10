require './database/db_connector'
require './models/user'

class Conversation
  attr_accessor :first_user, :second_user, :id

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

  def duplicate?
    client = create_db_client

    raw_data = client.query('SELECT * FROM conversations ' \
      "WHERE (first_user_id = #{@first_user.id} AND second_user_id=#{@second_user.id}) " \
      "OR (second_user_id = #{@second_user.id} AND first_user_id=#{@second_user.id})")

    conversations = Transform.to_conversations(raw_data)

    conversations.length == 1
  end

  def save
    return false unless valid?
    return false if duplicate?

    client = create_db_client
    client.query('INSERT INTO conversations(first_user_id, second_user_id) ' \
      "VALUES (#{@first_user.id}, #{@second_user.id})")
  end

  def self.find_all
    client = create_db_client
    raw_data = client.query('SELECT * FROM conversations')

    Transform.to_conversations(raw_data)
  end

  def self.find_by_id(id)
    client = create_db_client
    raw_data = client.query("SELECT * FROM conversations WHERE id=#{id}")

    Transform.to_conversation(raw_data)
  end

  def self.last_insert_id
    client = create_db_client
    raw_data = client.query('SELECT MAX(id) as id FROM conversations')

    Transform.to_id(raw_data)
  end

  def self.find_by_users_id(first_user_id, second_user_id)
    client = create_db_client

    raw_data = client.query('SELECT * FROM conversations ' \
      "WHERE (first_user_id = #{first_user_id} AND second_user_id=#{second_user_id}) " \
      "OR (second_user_id = #{first_user_id} AND first_user_id=#{second_user_id})")

    Transform.to_conversation(raw_data)
  end

  def self.find_all_by_user_id(user_id)
    client = create_db_client
    
    raw_data = client.query('SELECT * FROM conversations ' \
      "WHERE (first_user_id = #{user_id} OR second_user_id=#{user_id})")

    Transform.to_conversations(raw_data)
  end
end
