class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all
  end

  def self.longest
    longest_boat = Boat.all.order(length: :desc).first
    longest_boat.classifications
  end
end
