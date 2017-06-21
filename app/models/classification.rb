class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all.uniq
  end

  def self.longest
    Boat.longest_boat[0].classifications
  end
end
