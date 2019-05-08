class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all
  end

  def self.longest
    input = Boat.longest.pluck(:id)
    input1 = BoatClassification.where(boat_id: input).pluck(:classification_id)
    Classification.where(id: input1)
  end
end
