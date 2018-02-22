class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  	includes(boats: classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailboat_operators
  	includes(boats: classifications).where(classifications: {name: "Sailboat"})
  end

  def self.motorboat_operators
  	includes(boats: classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
  	where "id IN (?)", self.sailboat_operators.pluck(:id) & self.motorboat_operators.pluck(:id))
  end 
 	
  def self.not_sailors
  	where.not("id IN (?)"), self.sailors.pluck(:id)
  end 
end
