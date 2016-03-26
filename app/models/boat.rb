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
    Boat.where("length > ?", 20)
  end
  
  def self.last_three_alphabetically
    Boat.limit(3).order(:name).reverse_order
  end
  
  def self.without_a_captain
    Boat.where(captain_id: nil)
  end
  
  def self.sailboats
    Boat.includes(:classifications).where("classifications.name = ?", "Sailboat")   
  end
  
  def self.with_three_classifications 
    joins(:classifications).group("boat_id").having("count(*) == 3")  
  end
  
  def self.longest
    #Boat.limit(1).order(:length).reverse_order
    order('length DESC').first
  end
  
end
