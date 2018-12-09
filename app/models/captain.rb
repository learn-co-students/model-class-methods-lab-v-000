class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    joins(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors & self.motorboaters)
  end

  def self.non_sailors
    # self.where.not(sailors)
    where.not(id: self.sailors.pluck(:id))
    # select("id NOT IN (?)", self.sailors)
  end

end
