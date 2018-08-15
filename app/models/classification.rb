class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def my_all
    self.all
  end

  def self.longest
    Boat.longest_boat.classifications
  end

end
