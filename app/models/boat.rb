class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.limit(5)
  end

  def self.dinghy
    self.where('length < 20')
  end

  def self.ship
    self.where('length >= 20')
  end

  def self.last_three_alphabetically
    self.order(:name).reverse_order.limit(3)
  end

  def self.without_a_captain
     self.where(captain: nil)
  end

  def self.sailboats
    sailboats = Classification.where(name: 'Sailboat')
    boat_classifications = BoatClassification.where(classification_id: sailboats)
    boat_classifications = boat_classifications.pluck(:boat_id)
    boats = Boat.where(id: boat_classifications)
  end

  def self.with_three_classifications
    boat_ids = BoatClassification.having('Count(boat_id) = 3').group('boat_id').pluck(:boat_id)
    Boat.where(id: boat_ids)
  end


end
