class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.limit(5)
  end

  def self.dinghy
    Boat.where(["length < ?", 20])
  end

  def self.ship
    Boat.where(["length >= ?", 20])
  end

  def self.last_three_alphabetically
    Boat.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    Boat.where(captain_id: ['', nil])
  end

  def self.sailboats
    sailboat_id = Classification.find_by(name: 'Sailboat').id
    Boat.joins(:boat_classifications).where('classification_id = ?', sailboat_id)
  end

  def self.with_three_classifications
    Boat.joins(:boat_classifications).group('boat_classifications.boat_id').having('count(boat_classifications.classification_id) = ?', 3)
  end
end
