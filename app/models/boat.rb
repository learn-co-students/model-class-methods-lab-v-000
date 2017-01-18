class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    limit(5)
  end


  def self.dinghy
    where("length < ?", 20)
  end

  def self.ship
    where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil )
  end

  def self.sailboats
    joins("INNER JOIN boat_classifications ON boat_classifications.boat_id = boats.id INNER JOIN classifications ON  classifications.id = boat_classifications.classification_id AND classifications.name = 'Sailboat'")
  end

  def self.with_three_classifications
    joins(:boat_classifications).having('COUNT(boat_classifications.classification_id) = 3').group('boat_classifications.boat_id')
  end



end
