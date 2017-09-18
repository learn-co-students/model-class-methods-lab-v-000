class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  #returns the first five Boats boats
  def self.first_five
    Boat.limit(5)
  end

  #returns boats shorter than 20 feet
  def self.dinghy
    Boat.where(Boat.arel_table[:length].lt(20))
  end

  #returns boats 20 feet or longer
  def self.ship
    Boat.where(Boat.arel_table[:length].gteq(20))
  end

  #returns last three boats in alphabetical order
  def self.last_three_alphabetically
    Boat.order(name: :desc).limit(3)
  end

  #returns boats without a captain
  def self.without_a_captain
    Boat.where(Boat.arel_table[:captain_id].eq(nil))
  end

  #returns all boats that are sailboats
  def self.sailboats
    Boat.joins(:classifications).where(classifications: {name: 'Sailboat'})
  end

  #returns boats with three classifications
  def self.with_three_classifications
    Boat.joins(:boat_classifications).group('boat_id').having('count(classification_id) = 3')
  end

  #returns all boats that are catamarans
  def self.catamarans
    Boat.joins(:classifications).where(classifications: {name: 'Catamaran'})
  end

end
