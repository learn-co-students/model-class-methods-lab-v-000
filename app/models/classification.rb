class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    # SELECT * FROM classifications
    all
  end

  def self.longest

    # SELECT boats.name AS boatname, classifications.name AS classname FROM boats
    # INNER JOIN boat_classifications
    # ON boats.id = boat_classifications.boat_id
    # INNER JOIN classifications
    # ON boat_classifications.classification_id = classifications.id
    # ORDER BY boats.length DESC
    #
    # SELECT classifications.name AS classname, boats.name AS boatname, boats.length FROM classifications
    # INNER JOIN boat_classifications
    # ON classifications.id = boat_classifications.boat_id
    # INNER JOIN boats
    # ON boats.id = boat_classifications.boat_id
    # ORDER BY boats.length DESC

      # SELECT "classifications".* FROM "classifications"
      # INNER JOIN "boat_classifications"
      # ON "classifications"."id" = "boat_classifications"."classification_id"
      # WHERE "boat_classifications"."boat_id" = ?  [["boat_id", 3]]
    Boat.longest.classifications


  end
end
