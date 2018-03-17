class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    id = Boat.longest.pluck(:id)
    self.joins(:boats).where('boat_id = ?', id)
  end
end
