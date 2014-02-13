class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  has_one :mixtape
  has_many :photos
  has_many :sent_messages, :class_name => "Message", :foreign_key => "author_id"
  has_many :received_messages, :class_name => "Message", :foreign_key => "recipient_id"
  has_many :correspondents, -> { uniq }, through: :received_messages, class_name: "User", source: :author

  def chatees
    (correspondents + sent_messages.map(&:recipient)).uniq
  end


  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      unless user.persisted?
        new_user = user.profile_assignment(auth)
        new_user.save!
        new_user.profile_photo_assignment
        new_user.recent_photo_assignment
      end
    end
  end

  def messages_with(other_user)
    (received_messages.where(author: other_user) + sent_messages.where(recipient: other_user)).sort_by(&:created_at)
  end

  def last_message_involving(other_user)
    messages_with(other_user).last
  end

  def profile_assignment(auth)
    self.provider = auth.provider
    self.uid = auth.uid
    self.email = auth.info.email
    self.password = Devise.friendly_token[0,20]
    self.name = auth.info.name
    self.birthday = auth.extra.raw_info.birthday
    self.location = auth.info.location
    self.auth_token = auth.credentials.token
    self.male = (auth.extra.raw_info.gender == 'male' ? true : false)
    self
  end

  def profile_photo_assignment
    profile_pictures.each_with_index do |profile_photo, index|
      new_photo = self.photos.create
      new_photo.image_url = profile_photo
      index < 5 ? new_photo.profile_picture = true : nil
      new_photo.save!
    end
  end

  def recent_photo_assignment
    tagged_pictures.each do |tagged_picture|
      new_photo = self.photos.create
      new_photo.image_url = tagged_picture
      new_photo.save!
    end
  end

  def profile_pictures
    # raise self.inspect
    graph = Koala::Facebook::API.new(self.auth_token)
    profile_album = []
    graph.get_connections("me", "albums").each do |album|
      album['name'] == 'Profile Pictures' ?  (profile_album << album) : nil
     end
    profile_photos = graph.get_connections("#{profile_album[0]['id']}", 'photos')
    profile_photos.map { |photo| photo['images'][0]['source']}
  end

  def tagged_pictures
    graph = Koala::Facebook::API.new(self.auth_token)
    albums = graph.get_connections("me", "photos")
    albums.map {|image| image['source']}
  end

  def age
    dob = self.birthday
    day, month, year = dob.slice(3,2), dob.slice(0,2), dob.slice(6,4)
    dob = Time.new( year, month, day )
    ((Time.now - dob)/(60*60*24*365)).floor
  end

  def gender
    self.male ? 'Male' : 'Female'
  end

  def music_likes
    graph = Koala::Facebook::API.new(self.auth_token)
    music_profile = graph.get_connections("me", "music")
    music_profile.each do |musician|
      puts musician['name']
    end
  end

  def update_with_password(params, *options)
    update_attributes(params, *options)
  end

  def matches
    my_likes = Like.where( user_mix_id: self.mixtape_id )
    my_likes != nil ? doublematch(my_likes) : false
  end

  def doublematch(my_likes)
    matches = []
    my_likes.each do |like|
      if Like.find_by(user_mix_id: like.match_mix_id, match_mix_id: self.mixtape_id) != nil
        matches << User.find_by(mixtape_id: like.match_mix_id)
      end
    end
    matches
  end

end
