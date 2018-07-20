class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #returns captains of catamarans
    joins(boats: [:classifications]).where("classifications.name = ?", "Catamaran").uniq

  end

  def self.sailors
    #returns captains of sailboats
    joins(boats: [:classifications]).where("classifications.name = ?", "Sailboat").uniq

  end

  def self.motorboats
    joins(boats: [:classifications]).where("classifications.name = ?", "Motorboat").uniq
  end

  def self.talented_seafarers
    #returns captains of motorboats and sailboats
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboats.pluck(:id))
  end

  def self.non_sailors
    #returns captains who are not captains of sailboats
    where("id NOT IN (?)", self.sailors.pluck(:id))

  end


end
