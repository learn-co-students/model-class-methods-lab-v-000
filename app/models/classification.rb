class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  def self.longest
    boat = Boat.longest
    includes(:boats).where(boats: {id: boat.id})
  end
end
