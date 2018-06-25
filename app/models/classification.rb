class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
  # returns the classifications for the longest boat
    class_ids = Boat.order(length: :asc).last.classification_ids
    where(id: class_ids)
  end

end
