require 'pry'
class BoatClassification < ActiveRecord::Base
  belongs_to :boat
  belongs_to :classification

  def self.find_boats_by_classification (find_classification)
    self.where("classification_id == ?",find_classification).map { | classification | classification.boat_id }
  end

  def self.find_boats_by_number_classifications (n)
    self.group(:boat_id).having('COUNT(*)==?',n)
  end
end
