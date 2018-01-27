class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    limit(5).order('id')
  end

  def self.dinghy
    where("length < ?", 20)
  end

  def self.ship
    where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    limit(3).order('name DESC')
  end

  def self.without_a_captain
    where(captain: nil)
  end

  def self.sailboats
    joins(:classifications).merge(Classification.where(name: "Sailboat"))
  end
# SELECT "boats".* FROM "boats" INNER JOIN "boat_classifications"
# ON "boat_classifications"."boat_id" = "boats"."id"
# INNER JOIN "classifications"
# ON "classifications"."id" = "boat_classifications"."classification_id"
# WHERE "boats"."name" = ?  [["name", "Sailboat"]]

  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("COUNT(*)=3").select("boats.*")
  end

  def self.longest
    order('length DESC').first
  end
end
