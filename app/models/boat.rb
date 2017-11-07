class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    # SELECT name FROM boats LIMIT 5
    limit(5).select("name")
  end

  def self.dinghy
    # SELECT name FROM boats WHERE length < 20
    where("length < ?", 20).select("name")
  end

  def self.ship
    # SELECT name FROM boats WHERE length >= 20
    where("length >= ?", 20).select("name")
  end

  def self.last_three_alphabetically
    # SELECT name FROM boats ORDER BY name DESC LIMIT 3
    order(:name).reverse_order.limit(3).select("name")
  end

  def self.without_a_captain
    # SELECT name FROM boats WHERE captain_id IS NULL
    where("captain_id IS NULL").select("name")
  end

  def self.sailboats
    # SELECT boats.name, classifications.name FROM boats
    # INNER JOIN boat_classifications
    # ON boats.id = boat_classifications.boat_id
    # INNER JOIN classifications
    # ON boat_classifications.classification_id = classifications.id
    # WHERE classifications.name = "Sailboat"

    where("classifications.name = ?", "Sailboat").joins("INNER JOIN boat_classifications
      ON boats.id = boat_classifications.boat_id
      INNER JOIN classifications
      ON boat_classifications.classification_id = classifications.id").select("boats.name")

  end

  def self.with_three_classifications
    # SELECT boats.name FROM boats
    # INNER JOIN boat_classifications
    # ON boats.id = boat_classifications.boat_id
    # GROUP BY boats.id
    # HAVING COUNT(boat_classifications.classification_id) = 3
    joins(:boat_classifications).group("boats.id").having("COUNT(boat_classifications.classification_id) = ?", 3).select("boats.name")
  end

end
