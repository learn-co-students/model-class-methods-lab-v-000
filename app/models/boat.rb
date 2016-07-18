class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
	
	def self.first_five 
		Boat.order('id asc').limit(5)
	end
	
	def self.dinghy #shorter than 20 feet
		Boat.where("length < '20'")
	end
	
	def self.ship #greater than or equal to 20 feet
		Boat.where("length >= '20'")
	end
	
	def self.last_three_alphabetically
		Boat.order('name desc').limit(3)
	end
	
	def self.without_a_captain
		Boat.where(captain: nil)
	end
	
	def self.sailboats
		Boat.joins(:classifications).where({classifications: {name: "Sailboat"}})
	end
	
	def self.with_three_classifications # I could not solve this wow
		Boat.joins(:classifications).group(:boat_id).having('count(classification_id) = 3')
	end
	
	def self.by_classification(classification)
		Boat.joins(:classifications).where('classifications.name = ?', classification)
	end
	
	def self.longest
		Boat.order('length desc').limit(1)
	end
end
