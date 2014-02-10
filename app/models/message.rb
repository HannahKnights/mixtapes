class Message < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  belongs_to :recipient, :class_name => "User"



  def find_user_name(message)
    User.find(message.author_id).name
  end 

  def self.new_reply(prev_message, user)    
    new({
      subject: "RE: #{prev_message.subject}",
      body: prev_message.body,
      recipient: prev_message.author
    })
  end


end
