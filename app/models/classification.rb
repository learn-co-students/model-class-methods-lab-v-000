class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all.uniq

    # SELECT DISTINCT classifications.* FROM classifications
  end

  def self.longest
    max_length = Boat.maximum('length')
    includes(:boats).where(boats: {length: max_length})

    #=> First Query
    # SELECT MAX("boats"."length") FROM "boats"

    #=> Second Query
    # SELECT "classifications"."id" AS t0_r0, "classifications"."name" AS t0_r1, "classifications"."created_at" AS t0_r2, "classifications"."updated_at" AS t0_r3, "boats"."id" AS t1_r0, "boats"."name" AS t1_r1, "boats"."length" AS t1_r2, "boats"."captain_id" AS t1_r3, "boats"."created_at" AS t1_r4, "boats"."updated_at" AS t1_r5 FROM "classifications"
    #   LEFT OUTER JOIN "boat_classifications" ON "boat_classifications"."classification_id" = "classifications"."id"
    #   LEFT OUTER JOIN "boats" ON "boats"."id" = "boat_classifications"."boat_id"
    #   WHERE "boats"."length" = ?  [["length", 34]]
  end
end
