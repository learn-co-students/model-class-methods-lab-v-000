class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


  def self.first_five
    #binding.pry
    order(id: :asc).limit(5)
  end

  def self.dinghy
    where("length < ?", 20)
  end

  def self.ship
    where("length >= 20")
  end

  def self.last_three_alphabetically
    #binding.pry
    order(name: :desc).limit(3)
  end

  def self.without_a_captain
    #binding.pry
    #joins(:captain)
    where(captain_id: nil)
  end

  def self.sailboats
    #binding.pry
    joins(:classifications)
    .where("classifications.name = ?", 'Sailboat')
    #joins(boat_classifications).on("id = boat_id")
  end

  def self.with_three_classifications
    binding.pry

  end





end
