class BoatClassification < ActiveRecord::Base
  belongs_to :boat
  belongs_to :classification

  def self.sailboat
    where(classification_id: Classification.sailboat).collect do |boat_classification|
      boat_classification.boat_id
    end
  end

  def self.motorboat
    where(classification_id: Classification.motorboat).collect do |boat_classification|
      boat_classification.boat_id
    end
  end

  def self.catamaran
    where(classification_id: Classification.catamaran).collect do |boat_classification|
      boat_classification.boat_id
    end
  end

  def self.boat_classification_count
    i = select(:boat_id).group(:boat_id).having("count(boat_id) = 3")
    i.collect{|c|c.boat_id}
  end
end
