class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications


  def self.my_all 
	Classification.all
  end

  def self.longest 
     Boat.all.max{ |a, b| a.length <=> b.length }.classifications
  end
end
