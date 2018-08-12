class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all 
  end 

  def self.longest 
    Classification.joins(:boats).order(Boat.arel_table[:length].desc).limit(2)
  end 
end
