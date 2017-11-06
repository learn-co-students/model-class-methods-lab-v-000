class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # SELECT captains.name FROM captains
    # INNER JOIN boats
    # ON captains.id = boats.captain_id
    # INNER JOIN boat_classifications
    # ON boats.id = boat_classifications.boat_id
    # INNER JOIN classifications
    # ON boat_classifications.classification_id = classifications.id
    # WHERE classifications.name = "Catamaran"
    # GROUP BY captains.id

    where("classifications.name = ?", "Catamaran").joins("INNER JOIN boats
    ON captains.id = boats.captain_id
    INNER JOIN boat_classifications
    ON boats.id = boat_classifications.boat_id
    INNER JOIN classifications
    ON boat_classifications.classification_id = classifications.id").group("captains.id").select("name")
  end

  def self.sailors
    # SELECT captains.name FROM captains
    # INNER JOIN boats
    # ON captains.id = boats.captain_id
    # INNER JOIN boat_classifications
    # ON boats.id = boat_classifications.boat_id
    # INNER JOIN classifications
    # ON boat_classifications.classification_id = classifications.id
    # WHERE classifications.name = "Sailboat"
    # GROUP BY captains.id

    where("classifications.name = ?", "Sailboat").joins("INNER JOIN boats
    ON captains.id = boats.captain_id
    INNER JOIN boat_classifications
    ON boats.id = boat_classifications.boat_id
    INNER JOIN classifications
    ON boat_classifications.classification_id = classifications.id").group("captains.id").select("captains.name")

  end

  def self.talented_seamen
    # SELECT captains.name FROM captains
    # INNER JOIN boats
    # ON captains.id = boats.captain_id
    # INNER JOIN boat_classifications
    # ON boats.id = boat_classifications.boat_id
    # INNER JOIN classifications
    # ON boat_classifications.classification_id = classifications.id
    # WHERE classifications.name = "Motorboat"  OR classifications.name = "Sailboat"
    # GROUP BY classifications.id
    where("classifications.name = ? OR classifications.name = ?", "Motorboat", "Sailboat").joins("INNER JOIN boats
    ON captains.id = boats.captain_id
    INNER JOIN boat_classifications
    ON boats.id = boat_classifications.boat_id
    INNER JOIN classifications
    ON boat_classifications.classification_id = classifications.id").group("classifications.id").select("captains.name")
  end




end
