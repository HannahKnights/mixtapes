class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  has_one :mixtape

  def self.find_for_facebook_oauth(auth)
    puts auth
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      unless user.persisted?
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name 
        # user.image = auth.info.image # assuming the user model has an image
        puts '>>>>>>>>>>>>>>>>>> this is birthday'
        puts auth.extra.raw_info.birthday
        user.birthday = auth.extra.raw_info.birthday
        user.location = auth.info.location
        user.image_url = auth.info.image
        user.save!
      end
    end
  end  

end
