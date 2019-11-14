class AddMissingIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :accounts, :user_id
    add_index :events, :user_id
  end
end
