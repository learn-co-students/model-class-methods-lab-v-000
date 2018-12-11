class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  
  def self.first_five
    all.limit(5)
  end
  
  def self.dinghy
    where("length < 20")
  end
  
  def self.ship
    where("length >= 20")
  end
  
  def self.last_three_alphabetically
    order('name DESC').limit(3)
  end
  
  def self.without_a_captain
    where("captain_id IS ?", nil)
  end
  
  def self.sailboats
    Classification.find_by(name: "Sailboat").boats
  end
  
  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
  end
  
  def self.longest
    order("length DESC").first
  end
  
end
