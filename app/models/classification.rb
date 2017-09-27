class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all.uniq
  end

  def self.longest
    longest_boat = Boat.longest
    longest_boat.first.classifications
  end
end
