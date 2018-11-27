class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.select(name)
  end

  def self.longest
    self.joins(:boats).select(name).where(boats: {length: Boat.maximum('length')})
  end
end
