class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats


  def self.catamaran_operators
    joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seafarers
    self.where("id IN (?)", self.sailors.pluck(:id) & self.motorboats.pluck(:id))
  end

  def self.non_sailors
    sailor_ids = self.sailors.pluck(:id)
    where.not(id: sailor_ids)
  end
end
