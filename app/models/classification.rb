class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  def self.longest
    max = Boat.select("*, Max(boats.length)")
    joins(:boat_classifications, :boats).where("boats.length = ?", max.first.length).group("classifications.name").order("classifications.name DESC")
  end

end
