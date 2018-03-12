class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  def self.my_all
  #  binding.pry
        all
        #show all Classifications
  end
  def self.longest
  #  binding.pry
  #uses the longest method for the boat class
    Boat.longest.classifications
  end
end
