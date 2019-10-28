class CreateAccount < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :last_name
      t.string :gender
      t.integer :user_id

      t.timestamps
    end
  end
end
