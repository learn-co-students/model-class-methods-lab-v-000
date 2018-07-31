require 'pry'
class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    # Convoluted...
    # Find boat with the longest length.  Then get the boatclassifications for that boat.
    # Then map to the corresponding classification records.
    # And then convert back to activerecord relation
    # classifications = BoatClassification.find_by_boat(Boat.longest.id)
    # cs2 = classifications.map { | cs | Classification.find(cs.classification_id) }
    # Classification.where(id: cs2.map(&:id))
    # Much better implementation
    Boat.longest.classifications
  end
end
