class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats
  
  def self.catamaran_operators
  	includes(:classifications).where(classifications: {name: "Catamaran"}).uniq
  end
  
  def self.sailors
  	includes(:classifications).where(classifications: {name: "Sailboat"}).uniq
  end
  
  def self.motors
  	 	includes(:classifications).where(classifications: {name: "Motorboat"}).uniq
  end
  
  def self.talented_seamen
	self.where("id IN (?)", self.motors.pluck(:id) & self.sailors.pluck(:id))
  end
  
  def self.non_sailors
  	self.where.not("id IN (?)", self.sailors.pluck(:id)).uniq
  end
  
end
