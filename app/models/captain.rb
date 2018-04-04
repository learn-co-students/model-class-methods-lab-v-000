class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  	where(id: Boat.catamarans.pluck(:captain_id))
  end

  def self.sailors
  	where(id: Boat.sailboats.pluck(:captain_id))
  end

  def self.motorers
  	where(id: Boat.motorboats.pluck(:captain_id))
  end

  def self.talented_seafarers
  	ts = motorers.ids & sailors.ids
  	where(id: ts)
  end

  def self.non_sailors
  	where.not(id: Boat.sailboats.pluck(:captain_id))
  end
end
