class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.sailboat
  	where(name: "Sailboat")
  end 

  def self.motorboat
  	where(name: "Motorboat")
  end 

end
