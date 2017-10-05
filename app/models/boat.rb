class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    limit(5).order('id asc')
  end

  def self.dinghy
    where("length < ?", 20)
  end

  def self.ship
    where("length > ?", 20)
  end

  def self.last_three_alphabetically
    limit(3).order(name: :desc)
  end

  def self.without_a_captain
    where(captain: nil)
  end

  def self.sailboats
    joins(:boat_classifications, :classifications).where('classifications.name = ?', 'Sailboat').distinct
    # SELECT DISTINCT "boats".*
    # FROM "boats"
    # INNER JOIN "boat_classifications"
    #   ON "boat_classifications"."boat_id" = "boats"."id"
    # INNER JOIN "boat_classifications" "boat_classifications_boats_join"
    #   ON "boat_classifications_boats_join"."boat_id" = "boats"."id" INNER JOIN "classifications" ON "classifications"."id" = "boat_classifications_boats_join"."classification_id"
    #   WHERE (classifications.name = 'Sailboat')
  end

  def self.with_three_classifications
    joins(:boat_classifications).group('boats.id').having('count(classification_id) = 3')
  end

end
