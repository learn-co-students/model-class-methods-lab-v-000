class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


  def boats
    Boat.arel_table
  end

  def self.first_five
    #binding.pry
    order(id: :asc)
    limit(5)
  end

  def self.dinghy
    where("length < ?", 20)
  end

  def self.ship
    where("length >= 20")
  end

  def self.last_three_alphabetically
    binding.pry
    order(name: :desc)
    limit(3)
  end





end
