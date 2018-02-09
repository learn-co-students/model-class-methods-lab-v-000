class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  	self.where(:id => [Boat.catamarans.pluck(:captain_id)])
  	
  end

  def self.motorboaters
  	self.where(:id => [Boat.motorboats.pluck(:captain_id)])
  end

  def self.sailors
  	self.where(:id => [Boat.sailboats.pluck(:captain_id)])
  end

  def self.talented_seamen
  	self.where("id in (?) and id in (?)", Captain.sailors.pluck(:id), Captain.motorboaters.pluck(:id))
  end

  def self.non_sailors
  	self.where.not("id in (?)", Captain.sailors.pluck(:id))
  end
end
