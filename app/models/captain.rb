class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    all.includes(boats: :classifications).where(classifications: {name: 'Catamaran' })
  end

  def self.sailors
    all.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboat_operators
    all.includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    all.where("id in (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    all.where.not("id in (?)", self.sailors.pluck(:id))
  end

end