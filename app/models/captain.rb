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

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

  def self.talented_seafarers
    where("id IN (?) AND id IN (?)", self.sailors.pluck(:id), self.motorboat_operators.pluck(:id))
    #where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end


end
