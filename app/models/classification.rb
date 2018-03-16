class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
  	self.all
  end

  def self.longest
  	longest_boat = Boat.group("length").order("length DESC").limit(1).pluck(:id).join.to_i
  	joins(:boat_classifications).where("boat_classifications.boat_id = ?", longest_boat)
  end
end
