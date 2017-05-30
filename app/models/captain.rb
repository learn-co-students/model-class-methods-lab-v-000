class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).group("captains.id").where(classifications: {name: "Sailboat"})
  end

  def self.motorboats
    includes(boats: :classifications).group("captains.id").where(classifications: {name: "Motorboat"})
  end

  def self.talented_seamen
    where(id: (self.sailors.pluck(:id) & self.motorboats.pluck(:id)))
  end

  def self.non_sailors
    where.not(id: self.sailors.pluck(:id))
  end
end
