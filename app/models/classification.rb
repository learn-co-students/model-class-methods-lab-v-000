class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all
  end

  def self.longest
    longest_boat_ids = Boat.order(length: :desc).limit(1).ids
    Classification.joins(:boat_classifications).where('boat_id = ?', longest_boat_ids)
  end

end
