class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  def self.longest
    boat = Boat.max_length
    joins(:boats).where('boats.length = ?', boat)
  end
end
