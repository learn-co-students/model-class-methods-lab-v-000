
class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
    joins(boats: :classifications).where(classifications: {name: "Catamaran"})
# binding.pry    
  end
  
  def self.sailors
    joins(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end
  
  def self.talented_seafarers
    sailors.joins(boats: :classifications).where(classifications: {name: "Motorboat"}) 
# binding.pry
  end
  
  def self.non_sailors
binding.pry
  end
  
end
