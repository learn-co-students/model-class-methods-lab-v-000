class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  def self.longest
    joins(:boats).where("boats.name = ?", Boat.longest.pluck(:name))
    # this should work but it doesn't:
    # Boat.longest.classifications
  end
end
