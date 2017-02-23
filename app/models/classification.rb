class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    longest_boat_id = Boat.order("length DESC").limit(1).ids.first
    self.joins(:boats).where("boat_id = ?", longest_boat_id)
  end

end
