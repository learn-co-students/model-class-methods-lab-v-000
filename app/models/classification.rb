class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  
  
  def self.my_all
    #returns all classifications
    all
  end
  
  def self.longest
    #returns the classifications for the longest boat
    Boat.longest.classifications
  end
end
