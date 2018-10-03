class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    #self.all.sort[0, 5]
    #first(5)
    order(:id).limit(5)
  end

  def self.dinghy
    where("length < 20")
  end

  def self.ship
    where("length >= 20")
  end

  def self.last_three_alphabetically
    #all.sort_by(&:name).reverse[0,3]
    order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    includes(:classifications).where(classifications: {name: "Sailboat"})
  end

  def self.with_three_classifications
    joins(:classifications).group(:boat_id).having("count(classification_id) = ?", 3)
    #those_boats = []
    #self.all.each do |boat|
    #  those_boats << boat if boat.classifications.count == 3
    #end
    #those_boats
  end

  def self.longest
    order(length: :desc).first
  end

end
