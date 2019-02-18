class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
  	all
  end	

  def self.longest
  	# joins(:boats).order('boats.length DESC').limit(1)
  	where("id IN (?)", Boat.longest.classifications.pluck(:id))

  end

end
