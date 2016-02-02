class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: { name: 'Catamaran'})
  end

  def self.sailors
    joins(boats: :classifications).where(classifications: { name: 'Sailboat'}).distinct
  end

  def self.motorboats
    joins(boats: :classifications).where(classifications: { name: 'Motorboat'}).distinct
  end

  def self.talented_seamen
    where('id in (?)', motorboats & sailors)
  end

  def self.non_sailors
    where.not('id in (?)', sailors.map(&:id))
  end
end
