class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.includes(boats: :classifications).where(classifications:{name: 'Catamaran'})
  end

  def self.sailors
    self.includes(boats: :classifications).where(classifications:{name: 'Sailboat'}).group('captains.id')
  end

  def self.motorboats
    self.includes(boats: :classifications).where(classifications:{name: 'Motorboat'}).group("captains.id")
  end

  def self.talented_seamen
    self.where(:id => motorboats & sailors)
  end

  def self.non_sailors
    self.where.not(:id => sailors.map(&:id))
  end
end
