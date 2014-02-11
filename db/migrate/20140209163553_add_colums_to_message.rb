class AddColumsToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :author_id, :integer
    add_column :messages, :recipient_id, :integer
    add_column :messages, :subject, :string
    add_column :messages, :body, :text
  end
end
