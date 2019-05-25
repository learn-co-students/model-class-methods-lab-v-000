class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
    # Join on boats and classifications WHERE classifcations.name = Catamaran
    joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end
  
  def self.sailors
    # Join on boats and classifications WHERE classifcations.name = Sailboat
    joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end
  
  def self.motorboaters
    # Join on boats and classifications WHERE classifcations.name = Motorboat
    joins(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end
  
  def self.talented_seamen
    # The & operator here will only include the unique ones with both qualities
    # Using addition fails, as well as && boolean
    where(id: self.sailors & self.motorboaters)
  end
  
  def self.non_sailors
    # The - symbol returns ALL NOT sailors, or non-sailors
    where(id: self.all - self.sailors)
  end
end
