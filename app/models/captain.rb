class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    captain_boat("Catamaran")
  end

  def self.sailors
    captain_boat("Sailboat").uniq
  end

  def self.talented_seafarers
    array = sailors & motorguys
    Captain.where(id: array.map(&:id))
  end

  def self.motorguys
    captain_boat("Motorboat")
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

  def self.captain_boat(boat_type)
    joins(:boats).merge(Boat.boat(boat_type))
  end
end

#captain has name
#captain has many boats with names and lengths
#each boat has many boat_classifications each with a classification
