class Captain < ActiveRecord::Base
  has_many :boats
  
    #no more assocations are needed because of boats's own associations with :classifications and :boat_classifications

  def self.catamaran_operators
    joins(boats: :classifications).where(classifications: {name: "Catamaran"})
    # "joins(boats: :classifications) #so when joining with a class that has an association to the attribute you need that you don't have a direct association with (in the model),
    #   such as with "boats" and it's having the needed class in a  "through:" relationship in it's own scope, treat the class needed as a value of the 
    #   class, such as "boats", with "boats" as the value's key, in a joins method ... so two items, not just on
  end

  def self.sailors
     joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboat_operators
    joins(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
    #explain all of this "where("id IN (?)")"? what ids do :id represent?
    # joins(boats: :classifications).where(classifications: {name: "Motorboat" OR name: "Sailboat"})
    #could I have done something like this instead of having to make a new method? how is the solution better?
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end