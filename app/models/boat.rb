class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    boats = all.limit(5)
    boats
  end

  def self.dinghy
    boats = all.where('length < 20')
  end

  def self.ship
    boats = all.where('length >= 20')
  end

  def self.last_three_alphabetically
    boats = all.order(:name).reverse_order.limit(3)
  end

  def self.without_a_captain
    boats = all.where(captain_id: nil)
  end

  def self.sailboats 
    sailboat_id = Classification.where(name: 'Sailboat')
    boat_ids = BoatClassification.where(classification_id: sailboat_id).pluck(:boat_id)
    boats = Boat.where(id: boat_ids)
    boats
  end

end
