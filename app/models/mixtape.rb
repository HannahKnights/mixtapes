class Mixtape < ActiveRecord::Base

belongs_to :user
has_and_belongs_to_many :tracks


  def self.filtered_by_age(min, max)
    puts min 
    puts max
  end

end
