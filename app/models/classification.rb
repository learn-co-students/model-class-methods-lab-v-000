class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all.distinct
  end

  def self.longest
    boat = Boat.longest.id
    joins(:boats).where(boats: { id: boat })
  end

end
