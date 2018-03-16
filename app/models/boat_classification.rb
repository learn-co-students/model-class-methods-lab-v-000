class BoatClassification < ActiveRecord::Base
  belongs_to :boat
  belongs_to :classification

  #<BoatClassification id: 1, boat_id: 1, classification_id: 1, 
  # created_at: "2017-12-15 20:50:47", updated_at: "2017-12-15 20:50:47">
end