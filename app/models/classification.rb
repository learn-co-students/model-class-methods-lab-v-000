class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all
  end

  def self.longest
    longest_boat_id = Boat.order(length: :desc).first()
    Classification.joins(:boats).where(boats: {id: longest_boat_id})
  end
end
