class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  # ONE WAY TO DO IT IN SQLITE (NOT PRECISELY THE SAME AS ABOVE):
  # SELECT captains.name
  # FROM boats
  # INNER JOIN boat_classifications ON boat_classifications.boat_id = boats.id
  # INNER JOIN captains ON boats.captain_id = captains.id
  # WHERE boat_classifications.classification_id = 3


  def self.sailors
    Captain.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seafarers
    Captain.includes(boats: :classifications).where(classifications: {name: "Motorboat", name: "Sailboat"}).uniq
  end

end
