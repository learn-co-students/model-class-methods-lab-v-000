class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    #returns all classifications
    all
  end

  def self.longest
    #returns the classifications for the longest boat
    #return classifications
    #limit by boat.length
    #find the classifications for that boat
    includes(:boats).where(boats: { name: Boat.longest_boat.name })
    #Boat.longest_boat.classifications

  end
end
