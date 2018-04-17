class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.where(id: Boat.catamarans.pluck(:captain_id))
  end

  def self.sailors
  	where(id: Boat.sailboats.pluck(:captain_id))
  end

  def self.motorboaters
  	where(id: Boat.motorboats.pluck(:captain_id))
  end

  def self.talented_seafarers
    self.where(id: motorboaters.ids & sailors.ids)
  end

  def self.non_sailors
    self.where.not(id: Boat.sailboats.pluck(:captain_id))
  end
end
