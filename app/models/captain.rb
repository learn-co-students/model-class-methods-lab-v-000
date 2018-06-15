class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where(classifications: {name: 'Catamaran'})
  end

  def self.sailors
    joins(boats: :classifications).group('captains.id').where(classifications: {name: 'Sailboat'})
  end

  def self.motorboats
    joins(boats: :classifications).group('captains.id').where(classifications: {name: 'Motorboat'})
  end

  def self.talented_seafarers
    Captain.sailors && Captain.motorboats
  end

  def self.non_sailors
    !Captain.sailors
  end
end
