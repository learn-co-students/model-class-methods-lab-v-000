class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
    ##all the classification!
  end

  def self.longest
    Boat.longest.classifications
    #return boat with longest classification
  end
end
