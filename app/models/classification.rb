class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    joins(:boat_classifications).where("boat_classifications.boat_id" => Boat.longest.pluck(:id))
  end
end
