class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    #returns the first five Boats
    all.limit(5)
  end

  def self.dinghy
    #returns boats shorter than 20 feet
    where("length < 20")
  end

  def self.ship
    #returns boats 20 feet or longer
    where("length >= 20")
  end

  def self.last_three_alphabetically
    # returns last three boats in alphabetical order
    all.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    # returns all boats that are sailboats
    includes(:classifications).where(classifications: { name: 'Sailboat' })
  end

  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
  end

  def self.non_sailboats
    where("id NOT IN (?)", self.sailboats.pluck(:id))
  end

  def self.longest
    order('length DESC').first
  end


end
