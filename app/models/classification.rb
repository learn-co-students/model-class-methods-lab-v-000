class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    where("id > ?", 0)
  end

  def self.longest
    boat_max = Boat.maximum(:length)
    joins(:boats).where('boats.length' => boat_max)
  end
end
