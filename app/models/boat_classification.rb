class BoatClassification < ActiveRecord::Base
  belongs_to :boat
  belongs_to :classification

  def self.boats_of_type(boat_type)
    self.where(classification_id: Classification.id_of_boat_type(boat_type))
  end

  def method_name

  end
end
