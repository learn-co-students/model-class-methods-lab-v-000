class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    self.joins(:boats).where(boats: {id: Boat.order('length desc').limit(1).ids[0]})
  end
end
