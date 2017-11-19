class Captain < ActiveRecord::Base
  has_many :boats

def self.catamaran_operators
  #binding.pry
  includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  #Event.includes(users: :profile)
  #If you want to include an association (we'll call it C) of an already
  #included association (we'll call it B), you'd use the syntax above.
  #https://stackoverflow.com/questions/24397640/rails-nested-includes-on-active-records
end

def self.sailors
  includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
end

def self.motorboaters
  includes(boats: :classifications).where('classifications.name = ?', 'Motorboat').uniq
end

def self.talented_seamen
  where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
end

def self.non_sailors
  where.not("id IN (?)", self.sailors.pluck(:id))
end

end
