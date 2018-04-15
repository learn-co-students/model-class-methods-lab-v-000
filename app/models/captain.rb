class Captain < ActiveRecord::Base
  has_many :boats
  def self.non_sailors #captains who don't have a sailboat (where the classification's name of the boat isnt a sailboat)
    SELECT captains.name FROM captains WHERE captains.name not in (
    SELECT captains.name FROM captains
    INNER JOIN boats ON boats.captain_id = captains.id
    INNER JOIN boat_classifications ON boat_classifications.boat_id = boats.id
    INNER JOIN classifications ON classifications.id = boat_classifications.classification_id
    WHERE classifications.name = "Sailboat");

  end
  def self.sailors
    SELECT captains.name FROM captains
  INNER JOIN boats ON boats.captain_id = captains.id
  INNER JOIN boat_classifications ON boat_classifications.boat_id = boats.id
  INNER JOIN classifications ON classifications.id = boat_classifications.classification_id
  WHERE classifications.name = "Sailboat" GROUP BY captains.name;
end
def self.talented_seafarers
  SELECT captains.name FROM captains
  INNER JOIN boats ON boats.captain_id = captains.id
  INNER JOIN boat_classifications ON boat_classifications.boat_id = boats.id
  INNER JOIN classifications ON classifications.id = boat_classifications.classification_id
  WHERE classifications.name = "Sailboat" OR classifications.name= "Motorboat" GROUP BY captains.name;a

end
def self.catamaran_operators
  SELECT captains.name FROM captains
INNER JOIN boats ON boats.captain_id = captains.id
INNER JOIN boat_classifications ON boat_classifications.boat_id = boats.id
INNER JOIN classifications ON classifications.id = boat_classifications.classification_id
WHERE classifications.name = "Catamaran" GROUP BY captains.name;
end

end
