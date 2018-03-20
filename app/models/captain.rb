class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
    joins(:boats => :classifications).where("classifications.name = 'Catamaran'") 
  end
  
  def self.sailors
    joins(:boats => :classifications).where("classifications.name = 'Sailboat'").group('captains.name') 
  end
  
  def self.motorboaters
    joins(:boats => :classifications).where("classifications.name = 'Motorboat'").group('captains.name') 
  end
  
  def self.talented_seafarers
    where("name IN (?)", self.sailors.pluck(:name) & self.motorboaters.pluck(:name))
  end
  
  def self.non_sailors
    where.not("name IN (?)", self.sailors.pluck(:name))
  end
end

# Captain.where("captains.name = 'Samuel Axe' OR captains.name = 'Captain Cook'")
