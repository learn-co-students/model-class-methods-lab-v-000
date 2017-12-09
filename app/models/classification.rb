class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  has_many :captains, through: :boats

  def self.my_all
    self.all
  end

  def self.longest
    joins(:boats).where("boats.length =?", Boat.maximum("length"))
  end
end
