class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  
  def self.first_five
    self.limit(5)
  end
  
  def self.dinghy
    self.where("length < ?", 20)
  end
  
  def self.ship
    self.where("length >= ?", 20)
  end
  
  def self.last_three_alphabetically
    self.order(name: :desc).limit(3)
  end
  
  def self.without_a_captain
    self.where(captain_id: nil)
  end
  
  def self.sailboats
    Classification.find_by(name: "Sailboat").boats
  end
  
  def self.with_three_classifications
    Boat.joins(:boat_classifications).group(:boat_id).having("count(boat_id) = ?", 3)
  end
  
end