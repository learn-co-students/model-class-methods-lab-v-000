class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    where.not(name: nil)
  end

  def self.longest
    bid = Boat.longest.pluck(:id)
    bcids = BoatClassification.where(boat_id: bid).pluck(:classification_id)
    Classification.where(id: [bcids])
  end
end
