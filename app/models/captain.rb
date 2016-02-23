class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  	# where(id: catamarans)
  	joins(boats: :classifications).where(classifications: {name: "Catamaran"}).uniq
  end

  # def self.catamarans
  # 	Boat.joins(:classifications).select("captain_id").where(classifications: {name: "Catamaran"})
  # end

  def self.sailors
  	# where(id: captain_sailboats)
  	joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seamen
  	where(captain[:id].in(motorboat_captain_ids).and(captain[:id].in(sailboat_captain_ids)))
  end

  def self.captain_sailboats
  	Boat.sailboats.select('captain_id')
  end

  def self.motorboats
  	Boat.joins(:classifications).select(:captain_id).where(classifications: {name: "Motorboat"})
  end

  def self.non_sailors
  	# where.(id: Captain.no_sailboats)
  	# joins(boats: :classifications).where.not(classifications: {name: "Sailboat"}).uniq
  	where.not(name: self.sailors.pluck(:name))

  end

  def self.no_sailboats
  	Boat.joins(:classifications).select("captain_id").where.not(classifications: {name: "Sailboat"})
  end

  def self.captain
  	Captain.arel_table
  end

  def self.motorboat_captain_ids
  	motorboats.collect { |m| m.captain_id }
  end

  def self.sailboat_captain_ids
  	captain_sailboats.collect { |m| m.captain_id }
  end


end
