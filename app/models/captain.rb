class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: 'Catamaran'})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: 'Sailboat'}).uniq
  end

  def self.sailboats
    includes(boats: :classifications).where(classifications: {name: 'Sailboat'})
  end

  def self.motorboats
    includes(boats: :classifications).where(classifications: {name: 'Motorboat'})
  end

  def self.talented_seamen
    where("id in (?)", self.sailboats.pluck(:id) & self.motorboats.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
