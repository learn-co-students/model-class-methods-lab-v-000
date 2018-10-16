class Captain < ActiveRecord::Base
  has_many :boats
	has_many :classifications, through: :boats

	def self.catamaran_operators
		#Boat.catamarans.joins(:captain).select(:'captains.name')
		self.classifications.where(classifications: {name: :Catamaran}).distinct
	end
	
	def self.sailors
		self.classifications.where(classifications: {name: :Sailboat}).distinct
	end
	
	def self.talented_seafarers
		motor_ = self.classifications.where(classifications: {name: :Motorboat}).distinct
		m_hash = {:'captains.name' => motor_.pluck(:name)}
 
		self.sailors.where(m_hash)
	end

	def self.non_sailors
		sail_capt = {:'captains.name' => self.sailors.pluck(:name)}

		self.classifications.where.not(sail_capt).distinct
	end

private
	def self.classifications
		self.joins(:classifications)
	end

end
