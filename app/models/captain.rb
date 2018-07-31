class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
    @captains = Captain.joins(boats: :classifications).where("classifications.name LIKE ?", "Catamaran")
  end
  
  def self.sailors
    @captains = Captain.joins(boats: :classifications).where("classifications.name LIKE ?", "Sailboat").distinct
  end
  
  def self.motorboats
    @captains = Captain.joins(boats: :classifications).where("classifications.name LIKE ?", "Motorboat").distinct
  end
  
  def self.talented_seafarers
    @captains = Captain.where(id: self.sailors.pluck(:id) & self.motorboats.pluck(:id))
  end
  
  def self.non_sailors 
    @captains = Captain.where.not(id: self.sailors.pluck(:id)).distinct
  end
  
  
end

