class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.find_motorboats
    includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seafarers
    #self.sailors & self.find_motorboats gives me what I want
    where(id: sailors.pluck(:id) & find_motorboats.pluck(:id))
  end

  def self.non_sailors
    where.not(id: sailors.pluck(:id))
  end
end
