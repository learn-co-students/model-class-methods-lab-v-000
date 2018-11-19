class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.includes(boats: :classifications).where('classifications.name = ?', 'Catamaran').references(:boats)
    #returns all captains of catamarans
  end

  def self.sailors
    Captain.includes(boats: :classifications).where('classifications.name = ?', 'Sailboat').references(:boats).uniq
    #returns captains with sailboats
  end

  def self.motorboaters
    Captain.includes(boats: :classifications).where('classifications.name = ?', 'Motorboat').references(:boats).uniq
    #returns captains with motorboats-so that we can use in talented seafarer method
  end

  def self.talented_seafarers
    #returns captains of motorboats and sailboats
    Captain.where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
    #since we have two id's we are passing in, from the sailboats and motorboats methods... we use IN to pass in multiple statements
  end

  def self.non_sailors
    #returns people who are not captains of sailboats
    #similar pattern to talented seafarers
    Captain.where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
