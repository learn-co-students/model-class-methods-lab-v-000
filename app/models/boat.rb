class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


  def self.first_five
    Boat.limit(5)
  end
  
  def self.dinghy
    Boat.where("length < ?", 20)
  end
  
  def self.ship
    Boat.where("length >= ?", 20)
  end
  
  def self.last_three_alphabetically
    Boat.order("name DESC").limit(3)
  end
  
  def self.without_a_captain
    where(captain: nil)
  end
  
  def self.sailboats
    #Returns all boats that are sailboats
    includes(:classifications).where(classifications: {name: "Sailboat"})
  end
  
  def self.with_three_classifications
    #returns boats with three classifications
    self.all.joins(:classifications).group("boat_id").having("count(classification_id) = 3")
  end

  def self.longest
    order("length DESC").first
  end
end
