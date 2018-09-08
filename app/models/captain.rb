class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
   #returns all captains of catamarans
   self.joins(boats: :classifications).where("classifications.name = 'Catamaran'")

  end

 def self.sailors
  # returns captains with sailboats
  self.joins(boats: :classifications).where("classifications.name = 'Sailboat'").uniq
 end

 def self.motorboaters
  # returns captains with sailboats
  self.joins(boats: :classifications).where("classifications.name = 'Motorboat'").uniq
 end

 def self.talented_seafarers
   #returns captains of motorboats and sailboats
   self.where("id IN (?)", self.sailors.ids & self.motorboaters.ids)

 end

 def self.non_sailors
   #returns people who are not captains of sailboats
  self. where("id NOT IN (?)", self.sailors.ids)

 end

end
