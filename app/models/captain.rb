class Captain < ActiveRecord::Base
  has_many :boats

  #returns all captains of catamarans
  def self.catamaran_operators
    Captain.joins(boats: [{boat_classifications: :classification} ]).where('classifications.name' => "Catamaran")
  end


  #returns captains with sailboats
  def self.sailors
    Captain.joins(boats: [{boat_classifications: :classification} ]).where('classifications.name' => "Sailboat").uniq
  end

  #returns captains of motorboats
  def self.motors
    Captain.joins(boats: [{boat_classifications: :classification} ]).where('classifications.name' => "Motorboat").uniq
  end


  #returns all talented seamen who operate sailboats and motorboats
  def self.talented_seamen
    where("id IN (?)", self.sailors & self.motors)
  end


  #returns people who are not captains of sailboats
  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
