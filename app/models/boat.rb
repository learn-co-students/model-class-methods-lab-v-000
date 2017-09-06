class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.limit(5)
  end

  def self.dinghy
    Boat.where(Boat.arel_table[:length].lt(20))
  end

  def self.ship
    Boat.where(Boat.arel_table[:length].gteq(20))
  end

  def self.last_three_alphabetically
    Boat.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    Boat.where(Boat.arel_table[:captain_id].eq(nil))
  end

  def self.sailboats
    Boat.joins(:classifications).where(classifications: {name: 'Sailboat'})
  end

  def self.with_three_classifications
    Boat.joins(:boat_classifications).group('boat_id').having('count(classification_id) = 3')
  end

  def self.catamarans
    Boat.joins(:classifications).where(classifications: {name: 'Catamaran'})
  end

end
