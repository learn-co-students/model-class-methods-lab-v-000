class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
      joins(boats: :classifications).where("classifications.name = 'Catamaran'")
  end 
  
  def self.sailors
      joins(boats: :classifications).where("classifications.name = 'Sailboat'").uniq
  end 

  
  def self.motorboats
      joins(boats: :classifications).where("classifications.name = 'Motorboat'").uniq
  end 
  
    
  def self.talented_seamen
    #  binding.pry
    
     where("name IN (?) ", self.sailors.pluck(:name) & self.motorboats.pluck(:name))
  end 
  
  def self.non_sailors
    #   joins(boats: :classifications).where("classifications.name != 'Sailboat'").uniq
       where.not("name IN (?) ", self.sailors.pluck(:name))
  end 
  
end


