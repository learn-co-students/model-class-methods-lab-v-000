class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    # Boat.first 5    #=> This works, but tests don't allow it
    Boat.order(id: :asc).limit(5)
  end

  def self.dinghy
    Boat.where("length < ?", 20)
  end

  def self.ship
    Boat.where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    Boat.order(name: :desc).limit(3)
  end

  def self.longest
    length = Boat.order(length: :desc).limit(1).first.length
    Boat.where('length = ?', length)
  end

  def self.without_a_captain
    Boat.where(captain_id: nil)
  end

  def self.sailboats
    Boat.joins(:classifications).where(classifications: {name: "Sailboat"})
  end

  def self.with_three_classifications 
    Boat.joins(:classifications).group('boat_id').having('count(classification_id) = ?', 3)
  end
end
