class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where('classifications.name = ?', 'Catamaran')
    #SELECT "captains".* FROM "captains"
    #INNER JOIN "boats" ON "boats"."captain_id" = "captains"."id"
    #INNER JOIN "boat_classifications" ON "boat_classifications"."boat_id" = "boats"."id"
    #INNER JOIN "classifications" ON "classifications"."id" = "boat_classifications"."classification_id"
    #WHERE (classifications.name = 'Catamaran')
  end

  def self.sailors
    joins(boats: :classifications).where('classifications.name = ?', 'Sailboat').uniq
  end

  def self.motorboats
    joins(boats: :classifications).where('classifications.name = ?', 'Motorboat').uniq
  end

  def self.talented_seamen

  end

  def self.non_sailors
    #self.
  #  self.joins(boats: :classifications).where('classifications.name != ?', 'Sailboat').uniq
  #  SELECT DISTINCT "captains".* FROM "captains"
  #  INNER JOIN "boats" ON "boats"."captain_id" = "captains"."id"
  #  INNER JOIN "boat_classifications" ON "boat_classifications"."boat_id" = "boats"."id"
  #  INNER JOIN "classifications" ON "classifications"."id" = "boat_classifications"."classification_id"
  #  WHERE (NOT (classifications.name = 'Sailboat'))
  end
end
