class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all
  end

  def self.longest
    
    boat = Boat.find_by(length: Boat.maximum(:length))
    boat.classifications
  end
end
