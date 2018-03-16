class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  #returns all classifications
  def self.my_all
    self.all
  end

  #returns the classifications for the longest boat
  def self.longest
    Boat.order(length: :desc).first.classifications
  end
end
