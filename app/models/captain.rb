class Captain < ActiveRecord::Base 
  has_many :boats

  def self.catamaran_operators
    joins(:boats).where(:boats => {id: Boat.catamarans})
  end

  def self.sailors
    #all captains with sailboats
    joins(:boats).group(:captain_id).where(:boats => {id: Boat.sailboats})    
  end

  def self.motorboat_captains
    joins(:boats).group(:captain_id).where(:boats => {id: Boat.motorboats})
  end
  
  def self.talented_seamen
    arr = sailors & motorboat_captains
    arr.map{|i| i.id}
    @result = Captain.where(:id => arr)
  end

  def self.non_sailors
    #all captains that do not have a sailboat
    self.where.not(id: self.sailors)
  end

end
