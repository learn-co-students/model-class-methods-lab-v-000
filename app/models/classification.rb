class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all
  end

  def self.longest
    joins(:boat_classifications).where("boat_id=?", Boat.longest.id)
  end
end
