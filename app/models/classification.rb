class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications


  def self.my_all
    where("id >= 0")
  end

  def self.longest
    Boat.find_by(length: Boat.maximum("length")).classifications
  end

end
