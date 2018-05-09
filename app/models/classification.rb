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
    #@boat = Boat.longest_boat #find the boat that has the greatest length
    #includes(:boats).where(boats: { name: @boat.name })
    includes(:boats).where(boats: { name: Boat.longest_boat.name })

  end
end
