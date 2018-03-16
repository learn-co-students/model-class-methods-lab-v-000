class Captain < ActiveRecord::Base
  has_many :boats

  #returns all captains of catamarans
  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  # returns captains with sailboats
  def self.sailors
  	includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  #returns captains with motorboats
  def self.motorboat
  	includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  # returns captains of motorboats and sailboats
  def self.talented_seamen
  	where("id IN (?)", self.sailors.pluck(:id) & self.motorboat.pluck(:id))
  end

  # returns people who are not captains of sailboats
  def self.non_sailors
  	where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
