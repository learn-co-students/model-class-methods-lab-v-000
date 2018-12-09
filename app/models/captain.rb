class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboat_operators
    joins(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    self.where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    sailor_ids = self.sailors.pluck(:id)
    where.not(id: sailor_ids)
  end
end
