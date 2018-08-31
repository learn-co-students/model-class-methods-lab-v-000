class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all
  end

  def self.longest
    longest_boat = Boat.order("length DESC").limit(1)[0]
    Classification.joins(:boat_classifications).where("boat_classifications.boat_id = ?", longest_boat.id)
  end
end
