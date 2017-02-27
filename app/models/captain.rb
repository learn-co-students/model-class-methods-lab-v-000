class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  	self.joins(:boats).joins(Boat.joins(:boat_classifications).join_sources)
  		.joins(BoatClassification.joins(:classification).join_sources)
  		.where("classifications.name = 'Catamaran'")
  end

  def self.sailors
  	self.joins(:boats).joins(Boat.joins(:boat_classifications).join_sources)
  		.joins(BoatClassification.joins(:classification).join_sources)
  		.where("classifications.name = 'Sailboat'").distinct
  end

  def self.motorboats
  	self.select("captains.name").joins(:boats).joins(Boat.joins(:boat_classifications).join_sources)
  		.joins(BoatClassification.joins(:classification).join_sources)
  		.where("classifications.name = 'Motorboat'").distinct
  end

  def self.talented_seamen
  	sailor_array = []
  	motorboat_array = []
  	sailors.each do |sailor|
  		sailor_array << sailor.name
  	end

  	motorboats.each do |motorboat|
  		motorboat_array << motorboat.name
  	end
  	both_string = ""
  	both_array = motorboat_array & sailor_array
  	both_array.each do |name|
  		both_string += "captains.name = '#{name}' OR "
  	end
  	self.where(both_string[0..-5])
  end

  def self.non_sailors
  	sailor_string = ""
  	sailors.each do |motorboat|
  		sailor_string += "captains.name != '#{motorboat.name}' AND "
 	end  
 	self.where(sailor_string[0..-5])
  end
end
