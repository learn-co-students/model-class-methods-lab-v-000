class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
    Captain.includes(:boats).where("boats.classifications = ?", "Catamaran")
  end
  
  def self.sailors
  end
  
  def self.talented_seafarers
  end
  
  def self.non_sailors
  end
  
end
