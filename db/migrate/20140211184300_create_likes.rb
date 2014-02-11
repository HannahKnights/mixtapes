class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.boolean :like
      t.integer :user_id
      t.integer :match_id
      t.boolean :block

      t.timestamps
    end
  end
end
