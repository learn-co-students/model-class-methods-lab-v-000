class Captain < ActiveRecord::Base
  has_many :boats


def self.catamaran_operators
    #returns all captains of catamarans
  Captain.joins(boats: :classifications).where(classifications: {name: "Catamaran"}).uniq
end

def self.motorboats
    Captain.joins(boats: :classifications).where(classifications: {name: 'Motorboat'}).uniq
end

  #returns captains with sailboats
def self.sailors
  Captain.joins(boats: :classifications).where(classifications: {name: 'Sailboat'}).uniq
end

def self.talented_seafarers
#returns captains of motorboats and sailboats
  where("id IN (?)", Captain.sailors.pluck(:id) & Captain.motorboats.pluck(:id))
end

def self.non_sailors
  #{}returns people who are not captains of sailboats
  #includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  where("id NOT IN (?)", Captain.sailors.pluck(:id))
end

end
