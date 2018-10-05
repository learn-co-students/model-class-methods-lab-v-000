class CreateBoats < ActiveRecord::Migration[4.2]
  def change
    create_table :boats do |t|
      t.string  :name
      t.integer :length
      t.integer :captain_id

      t.timestamps null: false
    end
  end
end
