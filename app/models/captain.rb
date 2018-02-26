class Captain < ActiveRecord::Base
  has_many :boats

#returns all captains of catamarans
  def self.catamaran_operators
#Captain has_many :boats Boat has_many :classifications, through: :boat_classifications
    Captain.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

#returns captains with sailboats
  def self.sailors
    Captain.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  # def self.motorboaters
  #   Captain.includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  # end

#returns captains of motorboats and sailboats
  def self.talented_seafarers
    Captain.where("id IN (?)",Captain.includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq.pluck(:captain_id) & Captain.sailors.pluck(:captain_id))
    #Captain.where("id IN (?)",Captain.motorboaters.pluck(:captain_id) & Captain.sailors.pluck(:captain_id))
  end

#returns people who are not captains of sailboats
  def self.non_sailors
    Captain.where.not("id IN (?)",Captain.sailors.pluck(:id))
  end
end
