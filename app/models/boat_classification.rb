class BoatClassification < ActiveRecord::Base
  belongs_to :boat
  belongs_to :classification

end
