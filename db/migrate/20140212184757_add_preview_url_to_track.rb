class AddPreviewUrlToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :preview_url, :string
  end
end
