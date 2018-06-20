class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(:boats).merge(Boat.joins(:classifications).merge(Classification.where(name: "Catamaran"))).uniq
  end

  def self.sailors
    joins(:boats).merge(Boat.joins(:classifications).merge(Classification.where(name: "Sailboat"))).uniq
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers #also totally confused, need to review
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors #also totally confused, need to review
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
