class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    includes(boats: :classifications)
      .where(classifications: {name: 'Catamaran'})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: 'Sailboat'}).uniq
  end

  def self.motors
    includes(boats: :classifications).where(classifications: {name: 'Motorboat'})
  end

  def self.talented_seafarers
    where("id IN (?)", sailors.pluck(:id) & motors.pluck(:id))
  end

  def self.non_sailors
    where("id NOT IN (?)", sailors.pluck(:id))
  end
end
