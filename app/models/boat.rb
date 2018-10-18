require 'pry'
class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    #where("id >=?", 5)
    self.limit(5)
  end

  def self.dinghy
    where("length <=?", 20)
  end

  def self.ship
    where("length >=?", 20)
  end

  def self.last_three_alphabetically
    #self.order([:name]).last(3).reverse
    self.limit(3).order('name desc')
  end

  def self.without_a_captain
    where(captain: nil)
  end

  def self.sailboats
    #binding.pry
    Classification.find_by(name: 'Sailboat').boats
  end

  def self.with_three_classifications
    #binding.pry
    joins(:classifications).group("boats.id").having("COUNT(boat_id)=3")
  end


end
