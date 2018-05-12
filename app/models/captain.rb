class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: 'Catamaran'})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: 'Sailboat'}).uniq
  end

  def self.motor_boats
    includes(boats: :classifications).where(classifications: {name: 'Motorboat'}).uniq
  end

  def self.talented_seafarers
    ids = sailors.pluck(:id) & motor_boats.pluck(:id)
    where(id: ids)
  end

  def self.non_sailors
    where.not(id: self.sailors.pluck(:id))
  end
end
