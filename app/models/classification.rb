class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  
  def self.my_all
    # self is implied
    all
  end
  
  def self.longest
    # The Boat.longest, then return its classification atttributes
    Boat.longest.classifications
  end
end
