class Captain < ActiveRecord::Base
  has_many :boats

  #SELECT "captains".* FROM "captains"
  #INNER JOIN "boats" ON "boats"."captain_id" = "captains"."id"
  #INNER JOIN "boat_classifications" ON "boat_classifications"."boat_id" = "boats"."id"
  #INNER JOIN "classifications" ON "classifications"."id" = "boat_classifications"."classification_id"
  #WHERE "classifications"."name" = 'Catamaran'
  def self.catamaran_operators
    self.joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  #SELECT DISTINCT "captains".* FROM "captains"
  #INNER JOIN "boats" ON "boats"."captain_id" = "captains"."id"
  #INNER JOIN "boat_classifications" ON "boat_classifications"."boat_id" = "boats"."id"
  #INNER JOIN "classifications" ON "classifications"."id" = "boat_classifications"."classification_id"
  #WHERE "classifications"."name" = 'Sailboat'
  def self.sailors
    self.joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seamen
    #SELECT DISTINCT "captains".* FROM "captains"
    #INNER JOIN "boats" ON "boats"."captain_id" = "captains"."id"
    #INNER JOIN "boat_classifications" ON "boat_classifications"."boat_id" = "boats"."id"
    #INNER JOIN "classifications" ON "classifications"."id" = "boat_classifications"."classification_id"
    #WHERE "classifications"."name" = 'Motorboat'
    motorboaters = self.joins(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq

    #SELECT "captains".* FROM "captains" WHERE (id IN (1,6))
    self.where("id IN (?)", self.sailors.pluck(:id) & motorboaters.pluck(:id))
  end

  def self.non_sailors
    #SELECT "captains".* FROM "captains" WHERE (id NOT IN (1,2,6))
    self.where("id NOT IN (?)", self.sailors.pluck(:id))
  end
end
