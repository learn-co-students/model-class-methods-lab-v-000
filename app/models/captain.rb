class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  includes(boats: :classifications).where(classifications: {name: "Catamaran"})
end

def self.sailors
  includes(boats: :classifications).where(classifications: { name: 'Sailboat' }).uniq
end

def self.motorboats
  includes(boats: :classifications).where(classifications: { name: 'Motorboat' })
end

def self.talented_seafarers
   self.where(id: self.sailors & self.motorboats)
 end

 def self.non_sailors
   where.not("id IN (?)", self.sailors.pluck(:id))
 end

end
