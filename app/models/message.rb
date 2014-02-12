class Message < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  belongs_to :recipient, :class_name => "User"

  def to_jbuilder
    Jbuilder.new do |json|
      json.body body
      json.created_at created_at.strftime('%-d %b %Y - %l:%M %P')
      json.short_created_at created_at.strftime('%l:%M:%S %P %-d %b')
      json.from 'me'
      json.author_id author_id
      json.recipient_id recipient_id
    end
  end

  def as_json
    to_jbuilder.attributes!
  end


  def find_user_name(message)
    User.find(message.author_id).name
  end 

  def self.new_reply(prev_message, user)    
    new({
      recipient: prev_message.author
    })
  end

  def group_messages(message)
    message.group_by
  end

end
