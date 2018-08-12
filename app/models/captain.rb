class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #binding.pry
   # binding.pry
    #Captain.where(Classification.arel_table[:name].eq("Catamaran"))
    #includes - where
    # joins - joins
    Captain.joins(:boats).joins(:boats => :boat_classifications).joins(:boats => :classifications).where(classifications:{name: "Catamaran"}).uniq!

  end

  def self.sailors 
    #includes - where
    Captain.joins(:boats).joins(:boats => :boat_classifications).joins(:boats => :classifications).where(classifications:{name: "Sailboat"}).uniq!

  end 

  def self.motorboats
    Captain.joins(:boats).joins(:boats => :boat_classifications).joins(:boats => :classifications).where(classifications:{name: "Motorboat"}).uniq!
  end 

  def self.talented_seafarers
 # binding.pry 
  #Captain.joins(:boats).joins(:boats => :boat_classifications).joins(:boats => :classifications).where(classifications:{name: "Sailboat"}).where(classifications:{name: ["Sailboat","Catamaran"]}).uniq!
    Captain.where(id: Captain.sailors & Captain.motorboats)
  end 

  def self.non_sailors
    Captain.where(id: Captain.all - Captain.sailors)
    #Captain.joins(:boats).joins(:boats => :boat_classifications).joins(:boats => :classifications).where(classifications:{name: ["Catamaran","Ketch", "Sloop", "Motorboat", "RIB", "Trawler", "Cat Rig Boat", "Bass Boat", "Pontoon Boat"]}).uniq!

  end 
end
