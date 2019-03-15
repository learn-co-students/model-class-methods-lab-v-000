class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: [:classifications]).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: [:classifications]).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.talented_seafarers
    includes(boats: [:classifications]).where(classifications: {name: "Motorboat"}, captains: {id: sailors.pluck(:id)})
  end

  def self.non_sailors
    where.not(id: sailors.pluck(:id))
  end
end
