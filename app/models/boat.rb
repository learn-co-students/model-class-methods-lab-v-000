class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  
  def self.first_five
    self.limit(5)
  end
  
  def self.dinghy
    self.where("length < 20")
  end
  
  def self.ship
    self.where("length >= 20")
  end
  
  def self.last_three_alphabetically
    self.order("name DESC").limit(3)
  end
  
  def self.without_a_captain
    self.where(captain: nil)
  end
  
  def self.sailboats
    includes(:classifications).where(classifications: {name: "Sailboat"})
  end
  
  def self.with_three_classifications
    self.all.joins(:classifications).group("boat_id").having("count(classification_id) = 3")
  end
end
