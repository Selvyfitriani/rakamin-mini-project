require './models/user'

class Transform
  def self.to_user(raw_data)
    user = nil

    raw_data.each do |datum|
      user = User.new(datum['username'], datum['name'])
    end

    user
  end

  def self.to_id(raw_data)
    id = 0
    raw_data.each do |datum|
      id = datum['id'].to_i
    end

    id
  end
end
