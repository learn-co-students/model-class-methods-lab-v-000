class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
  	Boat.all.limit(5)
  end

  def self.dinghy
  	Boat.all.where("length < 20")
  end

  def self.ship
  	Boat.all.where("length >= 20")
  end

  def self.last_three_alphabetically
  	Boat.all.order("name DESC").limit(3)
  end

  def self.without_a_captain
  	Boat.all.where(captain: nil)
  end

  def self.sailboats
  	Classification.all.where(name: "Sailboat").first.boats
  end

  def self.with_three_classifications
  	boats = Boat.all.to_a.keep_if {|boat| boat.classifications.count == 3}
  	boats_ids = boats.collect {|boat| boat.id}
  	Boat.all.where(id: boats_ids)
  end

end
