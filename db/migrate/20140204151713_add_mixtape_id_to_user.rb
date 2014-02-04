class AddMixtapeIdToUser < ActiveRecord::Migration
  def change
    add_reference :users, :mixtape, index: true
  end
end
