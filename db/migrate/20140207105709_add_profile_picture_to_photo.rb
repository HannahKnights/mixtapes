class AddProfilePictureToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :profile_picture, :boolean
  end
end
