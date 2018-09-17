class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
    Captain.joins(:boats => :classifications).where(classifications: {name: "Catamaran"})
  end
  
  def self.sailors
    Captain.joins(:boats => :classifications).where(classifications: {name: 'Sailboat'}).uniq
  end
  
  def self.motorboats
    Captain.joins(:boats => :classifications).where(classifications: {name: "Motorboat"})
  end
  
  def self.talented_seafarers
    Captain.where(id: Captain.sailors & Captain.motorboats)
  end
  
  def self.non_sailors
    Captain.where.not(id: Captain.sailors)
  end
end
