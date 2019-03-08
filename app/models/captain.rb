class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"}) 
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end 

  def self.talented_seafarers
    where({id: self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id)})
  end

  def self.non_sailors
    where.not({ id: self.sailors.pluck(:id)})
  end
end
