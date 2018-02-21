class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all
  end

  def self.longest
    Classification.where(id: BoatClassification.where(boat_id: Boat.order("length DESC").first.id).map(&:classification_id))
  end
end
