require 'pry'
class BoatClassification < ActiveRecord::Base
  belongs_to :boat
  belongs_to :classification

  def self.find_boats_by_category (category)
    self.where("classification_id == ?",category).map { | classification | classification.boat_id }
  end
end
