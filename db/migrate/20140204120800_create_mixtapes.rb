class CreateMixtapes < ActiveRecord::Migration
  def change
    create_table :mixtapes do |t|
      t.string :title
      t.text :song1

      t.timestamps
    end
  end
end
