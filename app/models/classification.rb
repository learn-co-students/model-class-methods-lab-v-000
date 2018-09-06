class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    #  returns all classifications
    Classification.all
   end

   def self.longest_returns_the_classifications_for_the_longest_boats
    binding.pry
    # returns the classifications for the longest boat
    Boat.longest.classifications
   end

end
