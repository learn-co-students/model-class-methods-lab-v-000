class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
      joins(:boats).where('boats.id' => Boat.catamarans.ids)
  end
  
  def self.sailors
      joins(:boats).where('boats.id' => Boat.sailboats.ids).uniq
  end
  
  def self.talented_seafarers
    where(id: self.joins(:boats).where('boats.id' => Boat.sailboats.ids) & self.joins(:boats).where('boats.id' => Boat.motorboats.ids))
  end
  
  def self.non_sailors
     where.not(id: self.sailors.ids) 
  end
  
end
