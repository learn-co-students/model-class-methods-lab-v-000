class CreateBoatClassifications < ActiveRecord::Migration[4.2]
  def change
    create_table :boat_classifications do |t|
      t.integer :boat_id
      t.integer :classification_id

      t.timestamps null: false
    end
  end
end
