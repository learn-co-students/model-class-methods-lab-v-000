class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  has_many :captains, through: :boats

  def self.my_all
    self.all
  end

  def self.longest
    Boat.longest.classifications
  end

end
