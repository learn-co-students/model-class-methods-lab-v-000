require 'pry'
class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def Boat::first_five
    Boat.limit(5)
  end

  def Boat::dinghy
    Boat.where("length < ?", 20)
  end

  def Boat::ship
    Boat.where("length >= ?", 20)
  end

  def Boat::last_three_alphabetically
    Boat.order(:name).reverse_order.limit(3)
  end

  def Boat::without_a_captain
    Boat.where(captain_id: nil)
  end

  def Boat::sailboats
    classification = Classification.where(name: "Sailboat")
    classification[0].boats
  end

  def Boat::with_three_classifications
    @ids = []
    hash = BoatClassification.group(:boat_id).count
    hash.each do |key, value|
      if value == 3
        @ids << key
      end  
    end  
    Boat.where(id: @ids)
  end
end
