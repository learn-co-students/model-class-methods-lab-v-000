class Captain < ActiveRecord::Base
  has_many :boats

def self.catamaran_operators
  includes(boats: :classifications).where(classifications: {name: 'Catamaran'})
end

def self.sailors
  includes(boats: :classifications).where(classifications: {name: 'Sailboat'}).uniq
end

def self.talented_seamen
  where("id IN (?)", self.sailors.pluck(:id) & self.motorboats.pluck(:id))
  # pluck can be used to query single or multiple columns from the underlying table of a model. It accepts a list of column names as argument and returns an array of values of the specified columns with the corresponding data type.
end

def self.motorboats
  includes(boats: :classifications).where(classifications: {name: 'Motorboat'})
end

def self.non_sailors
  where.not("id IN (?)", self.sailors.pluck(:id))
end

end
