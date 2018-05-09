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
    #find the boat that has the greatest length
    #find the classifications for that boat
    Boat.longest_boat
    byebug
  end
end
