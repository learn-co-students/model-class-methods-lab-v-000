class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.first(5) #limit(5)
  end

  def self.dinghy
    Boat.select {|boat| boat.length < 20} #where("length <= 20")
  end

  def self.last_three_alphabetically
    Boat.all.sort_by {|boat| boat.name}.last(3).reverse #test is backwards. Boat.order(:name).last(3).reverse; ##Boat.order(name: :desc).limit(3)##
  end

  def self.ship
    Boat.select {|boat| boat.length > 20} #Boat.where(["length > ?", 20])
  end

  def self.without_a_captain
    Boat.select {|boat| boat.captain.nil?} #Boat.where(captain: nil)
  end

  def self.sailboats
    includes(:classifications).where(classifications: {name: "Sailboat"})
  end

  def self.with_three_classifications
    select {|boat| boat.classifications.length == 3}
  end

end
