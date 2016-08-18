class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: [{boat_classifications: :classification}]).where('classifications.name = ?', 'Catamaran')

    # SELECT captains.* FROM captains
    #   INNER JOIN boats ON boats.captain_id = captains.id
    #   INNER JOIN boat_classifications ON boat_classifications.boat_id = boats.id
    #   INNER JOIN classifications ON classifications.id = boat_classifications.classification_id
    #   WHERE (classifications.name = 'Catamaran')
  end

  def self.sailors
    joins(boats: [{boat_classifications: :classification}]).where('classifications.name = ?', 'Sailboat').distinct

    # SELECT DISTINCT captains.* FROM captains
    #   INNER JOIN boats ON boats.captain_id = captains.id
    #   INNER JOIN boat_classifications ON boat_classifications.boat_id = boats.id
    #   INNER JOIN classifications ON classifications.id = boat_classifications.classification_id
    #   WHERE (classifications.name = 'Sailboat')
  end

  def self.talented_seamen
    where('id IN (?)', self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))

    # SELECT captains.* FROM captains
    #   WHERE (id IN (1,6))
  end

  def self.non_sailors
    where('id NOT IN (?)', self.sailors.pluck(:id))

    # SELECT captains.* FROM captains
    #   WHERE (id NOT IN (1,2,6))
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {name: 'Motorboat'})

    ## This would generate a query which contains a LEFT OUTER JOIN whereas the
    ## joins method would generate one using the INNER JOIN function instead.

    # SELECT "captains"."id" AS t0_r0, "captains"."name" AS t0_r1, "captains"."admiral" AS t0_r2, "captains"."created_at" AS t0_r3, "captains"."updated_at" AS t0_r4, "boats"."id" AS t1_r0, "boats"."name" AS t1_r1, "boats"."length" AS t1_r2, "boats"."captain_id" AS t1_r3, "boats"."created_at" AS t1_r4, "boats"."updated_at" AS t1_r5, "classifications"."id" AS t2_r0, "classifications"."name" AS t2_r1, "classifications"."created_at" AS t2_r2, "classifications"."updated_at" AS t2_r3
    #   FROM "captains"
    #   LEFT OUTER JOIN "boats" ON "boats"."captain_id" = "captains"."id"
    #   LEFT OUTER JOIN "boat_classifications" ON "boat_classifications"."boat_id" = "boats"."id"
    #   LEFT OUTER JOIN "classifications" ON "classifications"."id" = "boat_classifications"."classification_id"
    #   WHERE "classifications"."name" = 'Motorboat'
  end
end
