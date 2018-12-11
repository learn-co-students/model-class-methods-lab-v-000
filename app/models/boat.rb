class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
    # returns the first five boats
  end

  def self.dinghy
    where("length < 20")
    # returns boats shorter than 20 feet
  end

  def self.ship
    where("length >= 20")
    # returns boats 20 feet or longer
  end

  def self.last_three_alphabetically
    all.order(name: :desc).limit(3)
    # returns last three boats in alphabetical order
  end

  def self.without_a_captain
    where(captain_id: nil)
    # returns boats without a captain
  end

  def self.sailboats
    includes(:classifications).where(classifications: {name: 'Sailboat'})
    # returns all boats that are sailboats
  end

  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
    # returns boats with three classifications
  end

  def self.longest
    order("length DESC").first
    # return the longest boat
  end
end
