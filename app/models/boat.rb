class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  
  def self.first_five
    Boat.where("id < ?", 6)
  end
  
  def self.dinghy
    Boat.where("length < ?", 20)
  end

  def self.ship
    Boat.where("length >= ?", 20)
  end
  
  def self.last_three_alphabetically
    Boat.order(name: :desc).limit(3)
  end
  
  def self.without_a_captain
    Boat.where(captain_id: nil)
  end
  
  def self.sailboats
    Boat.joins(:boat_classifications, :classifications).where("classifications.name = ?", "Sailboat").distinct
  end
  
  def self.with_three_classifications
    BoatClassification.select("boat_id as id, classification_id").group(:boat_id).having("count(boat_id) = ?", 3).joins(:boat)
  end
  
end
