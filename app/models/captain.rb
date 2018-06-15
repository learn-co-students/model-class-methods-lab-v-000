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
    where(id: self.sailors & self.motorboats)
  end

  def self.non_sailors
    where(id: Captain.all - self.sailors)
  end

  #can also do
  #def self.non_sailors
  #  where.not(id: self.sailors)
  #end
end
