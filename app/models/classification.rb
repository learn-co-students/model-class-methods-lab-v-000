class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    # all classifications
    self.all.uniq
  end

  def self.longest
    #classifications for longest boat
    Boat.longest.classifications
  end
end
