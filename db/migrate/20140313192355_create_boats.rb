class CreateBoats < ActiveRecord::Migration
  def change
    create_table :boats do |t|
      t.string  :name
      t.integer :length
      t.integer :captain_id
      t.timestamps
    end
  end
end
