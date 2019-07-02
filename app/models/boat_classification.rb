class BoatClassification < ActiveRecord::Base
  belongs_to :boat
  belongs_to :classification
  # join table between a boat and a classification.
  # a boat can have many classifications
  # a classification can have many boats 
end
