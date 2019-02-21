class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    # all classifications
    #self.all.joins(:boat_classifications)
    all
  end

  def self.longest
    # classification for the longest boat
    Boat.longest.classifications
  end
end