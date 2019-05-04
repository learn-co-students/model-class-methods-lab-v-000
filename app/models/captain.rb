class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    where(boat.name = catamaran)
  end

  def self.sailors
    where(boat.classifications.name = sailboat)
  end

  def self.talented_seafarers
    # have motorboat and sailboat
  end

  def self.non_sailors
    # don't have sailboat
  end
end
