class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats
  
  def self.catamaran_operators
     Captain.joins(:boats).joins(:classifications).where(classifications: {name: "Catamaran"}).distinct
  end
  
  def self.sailors
     Captain.joins(:boats).joins(:classifications).where(classifications: {name: "Sailboat"}).distinct
  end
  
  def self.motormen
     Captain.joins(boats: :classifications).where('classifications.name = ?', "Motorboat").distinct
  end
  
  def self.talented_seamen
      where(id: self.sailors & self.motormen)
  end
  
  def self.non_sailors
      where(id: self.all-self.sailors)
  end
  
  
  
end
