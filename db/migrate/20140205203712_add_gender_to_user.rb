class AddGenderToUser < ActiveRecord::Migration
  def change
    add_column :users, :male, :boolean
  end
end
