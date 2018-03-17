class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: 'Catamaran'})
  end

  def self.sailors
    joins(boats: :classifications).where(classifications: {name: 'Sailboat'}).group(:captain_id)
  end

  def self.motorboats
    joins(boats: :classifications).where(classifications: {name: 'Motorboat'}).group(:captain_id)
  end

  def self.talented_seamen
    where(id: motorboats & sailors)
  end

  def self.non_sailors
    where.not(id: sailors)
  end
end
