class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    longest_boat = Boat.order(length: :desc).limit(1).pluck(:id)
    self.joins(:boats).where(boats: {id: longest_boat})
  end
end
