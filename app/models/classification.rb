class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  #returns all classifications
  def self.my_all
    all
  end

  #returns the classifications for the longest boat
  def self.longest
    longest = Boat.order(length: :desc).first
    longest.classifications
  end

end
