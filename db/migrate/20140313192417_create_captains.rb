class CreateCaptains < ActiveRecord::Migration
  def change
    create_table :captains do |t|
      t.string  :name
      t.boolean :admiral
      t.timestamps
    end
  end
end
