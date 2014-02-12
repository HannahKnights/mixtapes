class Like < ActiveRecord::Base

  belongs_to :post
  belongs_to :user_mix, class_name: "Mixtape"
  belongs_to :match_mix, class_name: "Mixtape"

end
