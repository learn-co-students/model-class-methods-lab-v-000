class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: 'Catamaran'})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: 'Sailboat'}).uniq
  end

  def self.motorboats
    includes(boats: :classifications).where(classifications: {name: 'Motorboat'}).uniq
  end

  def self.talented_seafarers
    where("id IN (?)", sailors.pluck(:id) & motorboats.pluck(:id))
    # includes(boats: :classifications).where(classifications: {name: ['Sailboat' 'Motorboat']}).uniq
  end

  def self.non_sailors
    where.not("id IN (?)", sailors.pluck(:id))

    # includes(boats: :classifications).where.not(classifications: {name: 'Sailboat'}).uniq
  end
end
