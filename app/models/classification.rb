class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    #Boat.longest.where(self.joins(:boats)) - not correct
    Boat.longest.classifications
    #returns the classifications for the longest boat - collection proxy
  end

end
