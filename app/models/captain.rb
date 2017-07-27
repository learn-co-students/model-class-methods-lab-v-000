class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators  
    Captain.joins(boats: [:boat_classifications, :classifications]).where(classifications: {name: "Catamaran"}).uniq
  end

  def self.sailors
    Captain.joins(boats: [:boat_classifications, :classifications]).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.talented_seamen
    array = Captain.joins(boats: [:boat_classifications, :classifications]).where(classifications: {name: "Sailboat"}).distinct & Captain.joins(boats: [:boat_classifications, :classifications]).where(classifications: {name: "Motorboat"}).distinct
    #converts from array back to active record relation
    Captain.where(id: array.map(&:id))
  end
 
  def self.non_sailors
    Captain.left_outer_joins(:boats).where( boats: { id: nil } )
  end
   
end

