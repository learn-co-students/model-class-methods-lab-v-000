class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end
  
  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
                                     #where("classifications.name = ?", 'Sailboat') this did not work.
  end
  
  def self.talented_seamen
    self.where(id: self.sailors.pluck(:id)).where(id: self.motorboaters.pluck(:id)).distinct
  end
  
  def self.motorboaters
    includes(boats: :classifications).where(classifications: {name: "Motorboat"}).distinct
  end
  
  def self.non_sailors
    self.where.not(id: self.sailors.pluck(:id)).distinct
  end
  
  
    
end
