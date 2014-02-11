class AddSongColumnToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :song, :string
  end
end
