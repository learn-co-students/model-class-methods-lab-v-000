class CreateCaptains < ActiveRecord::Migration[4.2]
  def change
    create_table :captains do |t|
      t.string  :name
      t.boolean :admiral

      t.timestamps null: false
    end
  end
end
