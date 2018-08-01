class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
      self.uniq(:name)
  end

  def self.longest
      self.joins(:boats).where("boats.name = ?", Boat.boat_longest.name)
  end
end
