class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
    Captain.joins(boats: [:classifications]).where("classifications.name = ?", "Catamaran")
  end
  
  def self.sailors
    Captain.joins(boats: [:classifications]).where("classifications.name = ?", "Sailboat").distinct
  end
  
  def self.talented_seafarers
   
    # # Captain.joins(boats: [:classifications]).where("classifications.name = ?", )
  end
  
  def self.non_sailors
   Captain.joins(boats: [:classifications]).where("classifications.name != ?", "Sailboat").distinct
    
  end
  
end
