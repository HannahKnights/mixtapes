class Photo < ActiveRecord::Base
  
  belongs_to :user
  validates :image_url, presence: true
  
end
