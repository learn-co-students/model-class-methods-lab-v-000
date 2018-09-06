class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


  def self.first_five
    select(:id).limit(5)
  end

  def self.dinghy
    where("length < 20")
  end

  def self.ship
    where("length > 20")
  end

  def self.last_three_alphabetically
     order('name DESC').limit(3)
  end

  def self.without_a_captain
    where("captain_id IS ?", nil)
  end

  def self.sailboats
    includes(:classifications).where("classifications.name = ?", "Sailboat")
  end

  def self.with_three_classifications
    # JOIN:
    # SELECT "boats".*
    # FROM "boats"
    # INNER JOIN "classifications" ON "classifications"."boat_id" = "boats"."id"

    # HAVING filters records that work on summarized GROUP BY results.
   joins(:classifications).having("count(classification_id) = 3").group("boat_id")
  end

    def self.longest
      # limit returns table, instead use the boat object
      order("length DESC").first
    end


end
