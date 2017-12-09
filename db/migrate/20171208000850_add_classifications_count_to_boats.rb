class AddClassificationsCountToBoats < ActiveRecord::Migration
  def change
    add_column :boats, :classifications_count, :integer, default: 0, null: false
  end
end
