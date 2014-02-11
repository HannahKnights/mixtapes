class AddTrackIdToMixtape < ActiveRecord::Migration
  def change
    add_reference :mixtapes, :track, index: true
  end
end
