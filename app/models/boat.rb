class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five 
	Boat.all.limit(5)
  end

  def self.dinghy 
	Boat.where( 'length < 20' )
  end

  def self.ship 
	Boat.where( 'length >= 20' )
  end

  def self.last_three_alphabetically
	Boat.order(name: :desc).limit(3)
  end  
   
  def self.without_a_captain 
	Boat.where(captain: nil)
  end 

  def self.sailboats 
	 Boat.where(name: ["H 28", "Nacra 17", "49er", "Laser", "Harpoon 4.7", "Sunfish"])
  end 
   
  def self.with_three_classifications 
	ids = Boat.all.select{ |b| b.classifications.length == 3 }
	Boat.where(id: ids)

  end 
end
