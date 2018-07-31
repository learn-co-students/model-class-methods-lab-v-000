class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

# returns all classifications
	def self.my_all
		all
	end

# returns the classifications for the longest boat (FAILED - 13)
	def self.longest
		Boat.order("length DESC").first.classifications
	end

end
