class BoatClassification < ActiveRecord::Base
  belongs_to :boat
  belongs_to :classification
end

# t.integer :boat_id
# t.integer :classification_id
