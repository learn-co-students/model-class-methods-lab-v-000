class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  
  def my_all
    self.classifications.all
  end
  
  def longest
    Boat.longest_boat.my_all
  end
  
end
