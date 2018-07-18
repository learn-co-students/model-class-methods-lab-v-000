class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #Nested joins look like this
    #boats will join with classifications here, then
    #classification is what has the name we're looking for
    joins(boats: :classifications).where("classifications.name='Catamaran'").uniq
  end

  def self.sailors
    joins(boats: :classifications).where("classifications.name='Sailboat'").uniq
  end

  def self.motorboaters
    joins(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    #no need for joins, the other helpers (#sailors and #motorboaters does that for us)
    #the arrays returned by the helpers are used to 'intersect' and return the IDs in both arrays
    #this list of ids is used in a where query to get the matching captain objects!
    where("id IN (?)", Captain.sailors.pluck(:id) & Captain.motorboaters.pluck(:id))
  end

  def self.non_sailors
    where("id NOT IN (?)", Captain.sailors.pluck(:id))
  end
end
