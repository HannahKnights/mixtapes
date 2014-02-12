class AddEchoNestSongIdToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :echonest_song_id, :string
  end
end
