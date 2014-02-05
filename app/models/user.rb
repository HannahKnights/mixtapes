class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  has_one :mixtape

  has_many :photos

  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      unless user.persisted?
        #Creating a user from fb details
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
        user.birthday = auth.extra.raw_info.birthday
        user.location = auth.info.location
        user.auth_token = auth.credentials.token
        # user.image_url = auth.info.image
        user.save!
        #Creating a profile image from fb image_url
        profile_image = Photo.create
        profile_image.image_url = auth.info.image
        profile_image.user_id = user.id        
        profile_image.save!

      end

    end

    # puts '>>> id of user'
    # puts id
    # user = User.last
    # puts '>>> id user.last'
    # puts user.id

    # # raise auth[:credentials][:token]

    # oauth_access_token = auth[:credentials][:token]
    # @graph = Koala::Facebook::API.new(oauth_access_token)

    # profile = @graph.get_connections("me", "music")
    # raise profile.inspect
  end

  def age
    dob = self.birthday
    day, month, year = dob.slice(3,2), dob.slice(0,2), dob.slice(6,4)
    dob = Time.new( year, month, day )
    ((Time.now - dob)/(60*60*24*365)).floor
  end 

  def music_likes
    graph = Koala::Facebook::API.new(self.auth_token)
    music_profile = graph.get_connections("me", "music")
    music_profile.each do |musician|
      puts musician['name']
    end
  end

  def tagged_pictures
    graph = Koala::Facebook::API.new(self.auth_token)
    albums = graph.get_connections("me", "photos")
    albums.map {|image| image['source']}
  end

  def profile_pictures
    graph = Koala::Facebook::API.new(self.auth_token)
    albums = graph.get_connections("me", "albums")
    pp = []
    albums.each do |alb|
      alb['name'] == 'Profile Pictures' ?  (pp << alb) : nil
     end
    album_id = pp[0]['id']
    # pp = graph.get_connections(album['ALBUM_ID'], "photos"])
    photos = graph.get_connections('me', 'album'[album_id], 'photos')
    photos
  end


  def update_with_password(params, *options)
    update_attributes(params, *options)
  end
end
