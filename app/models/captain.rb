class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    catamarans = Boat.joins(:classifications).where({classifications: { name: "Catamaran" }})
    self.where(id: catamarans.select(:captain_id))
  end

end

# joins(:boats).pluck(:id)
# SELECT "captains"."name" FROM "captains" INNER JOIN "boats" ON "boats"."captain_id" = "captains"."id"
# => [1, 2, 3, 4, 5, 6, 1, 1, 4, 6]

###

# joins(:boats).group(:captain_id).pluck(:captain_id)

# SELECT captain_id FROM "captains" INNER JOIN "boats" ON "boats"."captain_id" = "captains"."id" GROUP BY captain_id
# => [1, 2, 3, 4, 5, 6]
