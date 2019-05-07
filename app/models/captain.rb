class Captain < ActiveRecord::Base
  has_many :boats
  def self.non_sailors
    # SELECT captains.name FROM captains WHERE captains.name not in (
    # SELECT captains.name FROM captains
    # INNER JOIN boats ON boats.captain_id = captains.id
    # INNER JOIN boat_classifications ON boat_classifications.boat_id = boats.id
    # INNER JOIN classifications ON classifications.id = boat_classifications.classification_id
    # WHERE classifications.name = "Sailboat");
    sailor_ids= Captain.sailors.pluck(:id)
    Captain.select("captains.*").where.not(id: sailor_ids)


  end
  def self.sailors
  #   SELECT captains.* FROM captains
  # INNER JOIN boats ON boats.captain_id = captains.id
  # INNER JOIN boat_classifications ON boat_classifications.boat_id = boats.id
  # INNER JOIN classifications ON classifications.id = boat_classifications.classification_id
  # WHERE classifications.name = "Sailboat" GROUP BY captains.name;

Captain.select("captains.*").joins(boats: :classifications).where("classifications.name = 'Sailboat'").group("captains.name")
end
def self.motorboat_operators
  Captain.select("captains.*").joins(boats: :classifications).where("classifications.name = 'Motorboat'").group("captains.name")
end
def self.talented_seafarers
   # SELECT captains.name FROM captains
   # INNER JOIN boats ON boats.captain_id = captains.id
   # INNER JOIN boat_classifications ON boat_classifications.boat_id = boats.id
   # INNER JOIN classifications ON classifications.id = boat_classifications.classification_id
   # WHERE classifications.name = "Sailboat" AND classifications.name= "Motorboat" GROUP BY captains.name;
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
#Captain.select("captains.*").joins(boats: :classifications).where("classifications.name = 'Sailboat' AND classifications.name='Motorboat'").group("captains.name")
end
def self.catamaran_operators
#   SELECT captains.name FROM captains
# INNER JOIN boats ON boats.captain_id = captains.id
# INNER JOIN boat_classifications ON boat_classifications.boat_id = boats.id
# INNER JOIN classifications ON classifications.id = boat_classifications.classification_id
# WHERE classifications.name = "Catamaran" GROUP BY captains.name;
Captain.select("captains.*").joins(boats: :classifications).where("classifications.name = 'Catamaran'").group("captains.name")
end

end
