class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    #  returns all classifications
    Classification.all
   end

   def self.longest
   #we had to create the longest method in our boat class.
    Boat.longest.classifications
   end

end
