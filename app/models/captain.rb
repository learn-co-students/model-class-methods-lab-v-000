class Captain < ActiveRecord::Base
  has_many :boats


  def self.catamaran_operators
    Captain.joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    Captain.joins(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.motorboats
    Captain.joins(boats: :classifications).where(classifications: {name: "Motorboat"}).distinct
  end

  def self.talented_seafarers
    Captain.where("id IN (?)", self.motorboats & self.sailors)
  end

  def self.non_sailors
    Captain.where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
