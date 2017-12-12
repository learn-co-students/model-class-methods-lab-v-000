class Classification < ActiveRecord::Base

  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    longest_length = Boat.maximum("length")
    self.includes(:boats).where(:boats => {:length => longest_length})
  end
end
