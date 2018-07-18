class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    #returns all classifications
    @classifications = Classification.all.uniq
    @classifications
  end


    #returns the classifications for the longest boat

  def self.longest
   Boat.longest.classifications
 end

end
