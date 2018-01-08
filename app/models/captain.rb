class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
    #all captains whose boat classification include catamaran
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
    #captains whose boat classifications include sailboat
  end

  def self.motorboaters
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
    #captains whose boat classifications include motorboat
  end

  def self.talented_seamen
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
    #all where you find the same id returned for both methods??
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
    #where an id does not exist in sailors
  end
end
