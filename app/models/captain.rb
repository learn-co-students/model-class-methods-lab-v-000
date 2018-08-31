class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    self.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboats
    self.includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seafarers
    self.where("name IN (?)", self.sailors.pluck(:name) & self.motorboats.pluck(:name))
  end

  def self.non_sailors
    self.where("name NOT IN (?)", self.sailors.pluck(:name))
  end
end
