class AddBoatsCountColumnToCaptains < ActiveRecord::Migration
  def change
    add_column :captains, :boats_count, :integer
  end
end
