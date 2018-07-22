class BoatClassification < ActiveRecord::Base
  belongs_to :boat
  belongs_to :classification

  def self.get_classifications_by_boat(boat_id)
    where(boat_id: boat_id)
  end
end
