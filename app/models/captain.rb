class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # returns all captains of catamarans
    # What SQL search method can I use to find captains of the catamaran boats
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    # returns captains with sailboats
    # Join boats and classifications where the boats classification is a sailboat
    # Why do I have one extra sailor that the test doesn't ask for? - I have two captain Axe's
    # How do I get one Captain Axe instead of two?
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.motorboat_operators
    self.includes(boats: :classifications).where(classifications: {name: "Motorboat"}).distinct
  end

  def self.talented_seafarers
    # returns captains of motorboats and sailboats
    # Join boats with the classifications table, where the boats classification is Sailboats and Motorboats?
    # I need a SQL statement that finds all of the captains of motorboats
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    # returns people who are not captains of sailboats
    # find_by = where
    # find people that aren't captains of sailboats
    where.not("id IN (?)", self.sailors.pluck(:id)).distinct
  end
end
