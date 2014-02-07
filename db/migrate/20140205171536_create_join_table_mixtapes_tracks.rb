class CreateJoinTableMixtapesTracks < ActiveRecord::Migration
  def change
    create_join_table :mixtapes, :tracks do |t|
      # t.index [:mixtape_id, :track_id]
      # t.index [:track_id, :mixtape_id]
    end
  end
end
