class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #binding.pry
    #@catamaran_ops = Captain.boats.classifications.includes{ |c| c.name == "Catamaran" }
    Captain.all.includes(boats: :classifications).where(classifications: {name: 'Catamaran'})
  end
  # We want to return all captains of boats that have the classification of catamaran.

  def self.sailors
    Captain.all.includes(boats: :classifications).distinct.where(classifications: {name: 'Sailboat'})
  end
  def self.motorboats
    Captain.all.includes(boats: :classifications).distinct.where(classifications: {name: 'Motorboat'})
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.select(:id) & self.motorboats.select(:id))
  end

  def self.non_sailors
    non_sailors_test = where.not("id IN (?)", self.sailors.pluck(:id))
    #binding.pry
  end

end
