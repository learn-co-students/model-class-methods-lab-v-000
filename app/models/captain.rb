class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.includes(boats: :classifications).where(classifications: {name: "Catamaran"}).uniq
  end

  def self.sailors
    Captain.includes(boats: :classifications).where(classifications: {name: "Sailboat"} ).uniq
  end

  def self.motorboat_operators
    Captain.includes(boats: :classifications).where(classifications: {name: "Motorboat"} ).uniq
  end

  def self.talented_seafarers
    Captain.where('id in (?)', Captain.sailors.pluck(:id) & Captain.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    Captain.where('id not in (?)', Captain.sailors.pluck(:id))
  end
end
