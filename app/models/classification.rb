class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

    def self.my_all
    	all
	end

	def self.longest
		Classification.order(length: :desc).limit(1)
    	# Boat.longest.classifications
	end

end
