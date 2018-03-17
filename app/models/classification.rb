class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  
  scope :long, -> { joins(boats: [boat_classifications: :classification]).where(boats: {length: Boat.maximum('length')}).distinct }
  
  def self.my_all
    Classification.all
  end
  
  def self.longest
    Classification.long
  end
  
end
