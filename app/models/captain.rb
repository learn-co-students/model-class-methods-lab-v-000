class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

end


# ::catamaran_operators
#     returns all captains of catamarans (FAILED - 1)
#   ::sailors
#     returns captains with sailboats (FAILED - 2)
#   ::talented_seafarers
#     returns captains of motorboats and sailboats (FAILED - 3)
#   ::non_sailors
#     returns people who are not captains of sailboats (FAILED - 4)
