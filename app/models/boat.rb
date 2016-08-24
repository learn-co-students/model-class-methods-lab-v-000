class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
  	Boat.limit(5)
  end

  def self.dinghy
  	Boat.where("length<?", 20)
  end

  def self.ship
  	Boat.where("length>=?", 20)
  end

  def self.last_three_alphabetically
     Boat.order('name DESC').limit(3)
  end

  def self.without_a_captain
  	Boat.where(captain_id: nil)
  end

  def self.sailboats
    Boat.where(id: BoatClassification.where(classification_id: Classification.find_by(name: "Sailboat").id).map{|i| i.boat_id})
  end

  def self.with_three_classifications
  	Boat.where(id: BoatClassification.group(:boat_id).having("count(classification_id) = 3").map(&:boat_id))
  end

end

