class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
    # returns all captains of catamarans
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
    # returns captains with sailboats
  end

  def self.motorboat_operators 
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
    # returns captains with motorboats
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
    # returns captains of motorboats and sailboats
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
    # returns people who are not captains of sailboats
  end

end
