class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: :classifications).where(classifications: { name: "Catamaran"})
  end

  def self.motorboat_operators
    self.joins(boats: :classifications).where(classifications: { name: "Motorboat"}).uniq
  end

  def self.sailors
    self.joins(boats: :classifications).where(classifications: { name: "Sailboat"}).uniq
  end

  def self.talented_seafarers
    self.where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    self.where("id NOT IN (?)", self.sailors.pluck(:id))
  end
end
