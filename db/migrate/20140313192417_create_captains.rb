class CreateCaptains < ActiveRecord::Migration[5.2]
  def change
    create_table :captains do |t|
      t.string  :name
      t.boolean :admiral

      t.timestamps null: false
    end
  end
end
