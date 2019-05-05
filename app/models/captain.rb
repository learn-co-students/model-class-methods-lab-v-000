class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(:boats).where(name: "Catamaran")
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.talented_seafarers
    # have motorboat and sailboat
  end

  def self.non_sailors
    # don't have sailboat
  end
end
