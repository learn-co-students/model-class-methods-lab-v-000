class CreateBoatClassifications < ActiveRecord::Migration
  def change
    create_table :boat_classifications do |t|
      t.integer :boat_id
      t.integer :classification_id

      t.timestamps null: false
    end
  end
end
