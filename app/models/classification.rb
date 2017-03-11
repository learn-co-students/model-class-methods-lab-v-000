class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  def self.longest
    boat = Boat.order(length: :desc).limit(1)
    Classification.joins(:boats).where('boat_id = ?', boat.ids)
  end
end
