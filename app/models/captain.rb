class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  	self.joins(boats: [:classifications]).where({classifications: {name: "Catamaran"}})
  end

  def self.sailors
  	self.joins(boats: [:classifications]).where({classifications: {name: "Sailboat"}}).uniq
  end

  def self.motorboat_operators
  	includes(boats: [:classifications]).where({classifications: {name: "Motorboat"}}).uniq
  end

  def self.sailor_ids
  	self.sailors.pluck(:id)
  end

  def self.motorboat_ids
  	self.motorboat_operators.pluck(:id)
  end

  def self.talented_seamen
  	self.where(id: self.sailor_ids).where(id: self.motorboat_ids)
  end


  def self.non_sailors
  	self.where.not(id: self.sailor_ids)
  end
end
