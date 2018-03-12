class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #we know that a captain has many boats and a boat belongs to a captain
    #usings the boats table, and the classifications table (boat and classifications are linked by a join table in a has many through has many relationship)
    #For this query, we need to compare Captain table, with Boat table, with classification table
    #lets see the captain where in the classifications table ="catamaran"
#    binding.pry
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
  #  binding.pry
  #using the boats and classifications tables, lets see the Captains that have a boat with a classification named "Sailboat"
    includes(boats: :classifications).where(classifications: {name: "Sailboat"})
  end

  def self.talented_seafarers
    binding.pry
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))	
  end
  def self.non_sailors
    binding.pry
  end

end
