class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, -> { distinct }, through: :boats

  # def self.catamaran_operators
  # 	binding.pry
  # 	Classification.all.where("name = 'Catamaran'").first.boats.collect do |boat|
  # 		boat.captain
  # 	end
  # end

	def self.catamaran_operators
  		Classification.all.where("name = 'Catamaran'").first.captains
  	end

  	def self.sailors
  		Classification.all.where("name = 'Sailboat'").first.captains
  	end

  	def self.talented_seamen
  		sailboat_captains = Classification.all.where("name = 'Sailboat'").first.captains
  		motorboat_captains = Classification.all.where("name = 'Motorboat'").first.captains
  		captains = Captain.all.to_a.keep_if { |captain| sailboat_captains.include?(captain) && motorboat_captains.include?(captain) }
  		captain_ids = [captains[0].id, captains[1].id]
  		Captain.all.where(id: captain_ids)
  	end

  	def self.non_sailors
  		sailboat_captains = Classification.all.where("name = 'Sailboat'").first.captains
  		unwanted_captain_ids = sailboat_captains.collect { |captain| captain.id }
  		Captain.all.where.not(id: unwanted_captain_ids)
  	end


end
