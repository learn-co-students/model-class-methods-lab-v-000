class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where(classificatons: {name: "Catamaran"})
  end
  def self.talented_seamen
    where("id IN (?)", slef.sailors.pluck(:id) & self.motorboats.pluck(:id))
  end
  def self.sailors
    joins.(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end
  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
