class CreateEvent < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.datetime :checkin
      t.datetime :checkout
      t.integer :user_id

      t.timestamps
    end
  end
end
