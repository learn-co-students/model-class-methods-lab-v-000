class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  # ONE WAY TO DO IT IN SQLITE (NOT PRECISELY THE SAME AS ABOVE):
  # SELECT captains.name
  # FROM boats
  # INNER JOIN boat_classifications ON boat_classifications.boat_id = boats.id
  # INNER JOIN captains ON boats.captain_id = captains.id
  # WHERE boat_classifications.classification_id = 3


  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
