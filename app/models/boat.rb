class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.all.limit(5)
    #returns first five boats
  end

  def self.dinghy
    Boat.all.where("length < 20")
    #returns boats shorter than 20 feet
  end

  def self.ship
    Boat.all.where("length > 20")
    #returns boats 20 feet or longer
  end

  def self.last_three_alphabetically
    Boat.all.order(name: :desc).limit(3)
    #returns last three boats in alphabetical order
  end

  def self.without_a_captain
    Boat.all.where(captain: nil)
    #returns boats without a without_a_captain
  end

  def self.sailboats
    Boat.includes(:classifications).where('classifications.name = ?', 'Sailboat').references(:classifications)
    #returns all boats that are sailboats
  end

  def self.with_three_classifications
    #returns boats with three classifications
    #want to join the classifications table and group by the boats id's that have a count of 3
    joins(:classifications).group("boats.id").having("COUNT(*) = 3")
    # *  returns all the objects it finds in its query
  end



end
