class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"}).uniq
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seafarers
    #self.sailors & self.motorboat_operators
    where(id: self.sailors & self.motorboat_operators)
  end

  def self.non_sailors
    #self.all - self.sailors
    #where.not("id IN (?)", self.sailors.pluck(:id))
    where(id: self.all - self.sailors)
  end
end
