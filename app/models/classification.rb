class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
  	Classification.all 
  end

  def self.longest
  	@boat = Boat.maximum("length")
  	Classification.joins(:boats).where( boats: { length: @boat } )
  end

end
