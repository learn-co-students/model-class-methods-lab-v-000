class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    # binding.pry
    largest = Boat.all.pluck(:length).max
    self.where(id: BoatClassification.where(boat_id: Boat.where(length: largest).pluck(:id)).pluck(:classification_id))
  end
end
