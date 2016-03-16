class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
  	all
  end

  def self.longest
  	boat_id = Boat.order("length DESC").limit(1).pluck(:id)
  	Classification.joins(:boats).where("boats.id in (?)", boat_id)
  end

    
end
