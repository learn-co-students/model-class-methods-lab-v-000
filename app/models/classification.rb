class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

 #Classification::my_all returns all classifications
  def self.my_all
    all
  end

  #Classification#longest returns the classifications for the longest boat
  def self.longest
    Boat.longest.classifications
  end

end
