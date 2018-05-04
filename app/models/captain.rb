class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats
  def self.catamaran_operators
    self.joins(:classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    self.joins(:classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seafarers
    self.joins(:classifications).where(classifications: {name: "Sailboat" AND "Motorboat"}).uniq
  end

  def self.non_sailors
    self.joins(:classifications).where.not(classifications: {name: "Sailboat"})
  end
end
