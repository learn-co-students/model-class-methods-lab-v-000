class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
    #Boat.joins(:classifications).where('classifications.name = ?','Catamaran').select("captains.name").joins(:captain)
    Captain.joins(boats: [:classifications]).where("classifications.name = ?","Catamaran").uniq
  end
  
  def self.sailors
    Captain.joins(boats: [:classifications]).where("classifications.name = ?","Sailboat").uniq
  end
  
  def self.talented_seamen
     a = Captain.sailors & Captain.joins(boats: [:classifications]).where("classifications.name = ?","Motorboat").uniq 
     b = a.map {|e| e.id}
     Captain.where(id: b)
  end
  
  def self.non_sailors
     a = Captain.joins(boats: [:classifications]).where("classifications.name <> 'Sailboat'").uniq - Captain.sailors
     b = a.map {|e| e.id}
     Captain.where(id: b)
  end
end
