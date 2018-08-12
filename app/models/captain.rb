class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    # Captain.includes(boats: :classifications).where(classifications: {name: "Sailboat"})
    Captain.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  # need this method as a helper for #talented_seafarers
  def self.motorboat_operators
    Captain.includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    Captain.where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    Captain.where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
