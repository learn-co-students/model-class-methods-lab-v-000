class CreateCaptains < ActiveRecord::Migration
  def change
    create_table :captains do |t|
      t.string  :name
      t.boolean :admiral

      t.timestamps null: false
    end
  end
end
