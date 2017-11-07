class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    # limit(5).select("name")
    # SELECT name FROM boats LIMIT 5
    all.limit(5)
    # SELECT  "boats".* FROM "boats" LIMIT 5
  end

  def self.dinghy
    # where("length < ?", 20).select("name")
    # SELECT name FROM boats WHERE length < 20
    where("length < 20")
    # SELECT "boats".* FROM "boats" WHERE (length < 20)
  end

  def self.ship
    # where("length >= ?", 20).select("name")
    # SELECT name FROM boats WHERE length >= 20
    where("length >= 20")
    # SELECT "boats".* FROM "boats" WHERE (length >= 20)
  end

  def self.last_three_alphabetically
    # order(:name).reverse_order.limit(3).select("name")
    # SELECT name FROM boats ORDER BY name DESC LIMIT 3
    all.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    # where("captain_id IS NULL").select("name")
    # SELECT name FROM boats WHERE captain_id IS NULL
    where(captain_id: nil)
    # SELECT "boats".* FROM "boats" WHERE "boats"."captain_id" IS NULL
  end

  def self.sailboats
    # where("classifications.name = ?", "Sailboat").joins("INNER JOIN boat_classifications
    #   ON boats.id = boat_classifications.boat_id
    #   INNER JOIN classifications
    #   ON boat_classifications.classification_id = classifications.id").select("boats.name")

    # SELECT boats.name, classifications.name FROM boats
    # INNER JOIN boat_classifications
    # ON boats.id = boat_classifications.boat_id
    # INNER JOIN classifications
    # ON boat_classifications.classification_id = classifications.id
    # WHERE classifications.name = "Sailboat"

     includes(:classifications).where(classifications: { name: 'Sailboat' })
   #  SELECT "boats".*
   #  FROM "boats"
   #  LEFT OUTER JOIN "boat_classifications"
   #  ON "boat_classifications"."boat_id" = "boats"."id"
   #  LEFT OUTER JOIN "classifications"
   #  ON "classifications"."id" = "boat_classifications"."classification_id"
   #  WHERE "classifications"."name" = ?  [["name", "Sailboat"]]
  end

  def self.with_three_classifications
    # joins(:boat_classifications).group("boats.id").having("COUNT(boat_classifications.classification_id) = ?", 3).select("boats.name")
      # SELECT boats.name FROM boats
      # INNER JOIN boat_classifications
      # ON boats.id = boat_classifications.boat_id
      # GROUP BY boats.id
      # HAVING COUNT(boat_classifications.classification_id) = 3

    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
      # SELECT boats.* FROM "boats"
      # INNER JOIN "boat_classifications"
      # ON "boat_classifications"."boat_id" = "boats"."id"
      # INNER JOIN "classifications"
      # ON "classifications"."id" = "boat_classifications"."classification_id"
      # GROUP BY boats.id
      # HAVING COUNT(*) = 3
  end

  # SOLN HELPER METHOD
  def self.non_sailboats
    where("id NOT IN (?)", self.sailboats.pluck(:id))
    # SELECT "boats"."id" FROM "boats"
    # LEFT OUTER JOIN "boat_classifications"
    # ON "boat_classifications"."boat_id" = "boats"."id"
    # LEFT OUTER JOIN "classifications"
    # ON "classifications"."id" = "boat_classifications"."classification_id"
    # WHERE "classifications"."name" = ? [["name", "Sailboat"]]
    #
    # SELECT "boats".* FROM "boats" WHERE (id NOT IN (1,2,6,8,11,12))
  end

  # SOLN HELPER METHOD
  def self.longest
    order('length DESC').first
    # SELECT  "boats".* FROM "boats"  ORDER BY length DESC LIMIT 1
  end

end
