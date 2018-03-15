class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.includes(boats: [:classifications]).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    Captain.includes(boats: [:classifications]).where(classifications: {name: "Sailboat"}).group("captains.id")
  end

  def self.talented_seafarers
    Captain.includes(boats: [:classifications]).where(classifications: {name: ["Sailboat", "Catamaran"]}).group("captains.id")
  end

end
