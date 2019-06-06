class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  has_many :captains, through: :boats

  def self.my_all
    Classification.all
  end

  def self.longest
    longest_boat = Boat.all.order(length: :desc).limit(1)
    longest_boat.first.classifications
  end
end
