class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all
  end

  def self.longest
    Classification.where('id IN (?)',Boat.longest.classifications.pluck(:id))
  end
end
