class Captain < ActiveRecord::Base
  has_many :boats

def self.catamaran_operators
  includes(boats: :classifications).where(classifications: {name: "Catamaran"})
end

def self.sailors
  includes(boats: :classifications).group("captains.id").where(classifications: {name: "Sailboat"})
end

def self.motorboaters
  includes(boats: :classifications).group("captains.id").where(classifications: {name: "Motorboat"})
end

def self.talented_seafarers
  self.where("name IN (?)", self.sailors.pluck(:name) & self.motorboaters.pluck(:name))
end

def self.non_sailors
   self.where("name NOT IN (?)", self.sailors.pluck(:name))
end

end
