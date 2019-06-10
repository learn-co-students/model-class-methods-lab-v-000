class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    Classification.where(id: Boat.find_by(length: Boat.maximum("length")).classification_ids)
  end
end
