class Mixtape < ActiveRecord::Base


belongs_to :user
has_and_belongs_to_many :tracks
has_many :likes


end
