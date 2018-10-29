class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: { name: 'Catamaran' }).uniq
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: { name: 'Sailboat' }).uniq
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: { name: 'Motorboat' }).uniq
  end

  def self.talented_seafarers
    # where(["name IN (?) AND name IN (?)", self.sailors, self.motorboat_operators])
    where(name: self.sailors.pluck(:name) & self.motorboat_operators.pluck(:name))
    # where("name IN (?)", self.sailors).or(Captain.where("id = ?", self.motorboat_operators))
    # includes(boats: :classifications).where(classifications: { name: ['Sailboat', 'Motorboat']}).uniq
    # includes(boats: :classifications).where("classifications.name = ? OR classifications.name = ?", 'Sailboat', 'Motorboat').references(boats: :classifications).uniq
  end

  def self.non_sailors
    where.not(name: self.sailors.pluck(:name))
  end

  def self.non_motorboat_operators
    where.not(name: self.motorboat_operators.pluck(:name))
  end
end
