class CacheBoatClassificationsCount < ActiveRecord::Migration
  def change
    Boat.find_each do |boat|
       classifications_count = BoatClassification.where(boat_id: boat.id).size
       boat.update_attributes(classifications_count: classifications_count)
     end
  end
end
