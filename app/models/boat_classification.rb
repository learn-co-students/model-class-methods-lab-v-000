class BoatClassification < ActiveRecord::Base
  belongs_to :boat
  belongs_to :classification
  has_many :captains, through: :boats
end
