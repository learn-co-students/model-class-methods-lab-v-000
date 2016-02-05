class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  #Boat::first_five returns the first five Boats
  def self.first_five
    #where("id <= 5")
    all.limit(5)
  end

  #Boat::dinghy returns boats shorter than 20 feet
  def self.dinghy
    where("length < 20")
  end

  #Boat::ship returns boats 20 feet or longer
  def self.ship
    where("length >= 20")
  end

  #Boat::last_three_alphabetically returns last three boats in alphabetical order
  def self.last_three_alphabetically
    order(name: :desc).limit(3)
  end

  #Boat::without_a_captain returns boats without a captain
  def self.without_a_captain
    where(captain_id: nil)
  end

  #Boat::sailboats returns all boats that are sailboats
  def self.sailboats
    includes(:classifications).where(classifications: {name: "Sailboat"})
  end

  #Boat::with_three_classifications returns boats with three classifications
  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
  end
  
  def self.longest
    order('length DESC').first
  end

end
