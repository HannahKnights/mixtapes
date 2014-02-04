class AddUserIdToMixtape < ActiveRecord::Migration
  def change
    add_reference :mixtapes, :user, index: true
  end
end
