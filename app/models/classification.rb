class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  has_many :captains, -> { distinct }, through: :boats

  def self.my_all
  	Classification.all
  end

  def self.longest
	Boat.all.order("length DESC").limit(1).first.classifications
  end

end
