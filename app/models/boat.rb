class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


  def self.first_five
  	self.limit(5)
  	#binding.pry
  end

  def self.dinghy
  	self.where("length <?", 20)
  end

  def self.ship
  	self.where("length >=?", 20)
  end

  def self.last_three_alphabetically
  	self.order("name desc").limit(3)
  end

  def self.without_a_captain
  	self.where(captain: nil)
  end

  def self.sailboats
  	self.joins(:classifications).where(:classifications => {name: "Sailboat"})
  end

  def self.with_three_classifications
  	self.joins(:classifications).group(:boat_id).having("count(*) = 3")
  end

  def self.two_boats
  	self.joins(:classifications).group(:boat_id).having("id in (?)")
  end

  def self.catamarans
  	self.joins(:classifications).where(:classifications => {name: "Catamaran"})
  end

  def self.motorboats
  	self.joins(:classifications).where(:classifications => {name: "Motorboat"})
  end

  def self.otherboats
  	self.joins(:classifications).where(:classifications => {name: "Motorboat", name: "Sailboat"})
  end

end
