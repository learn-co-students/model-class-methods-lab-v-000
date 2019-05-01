class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.longest
    order("length DESC").first
  end

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    self.where("length < '20'")
  end

  def self.ship
    self.where("length > '20'")
  end

  def self.last_three_alphabetically
    self.order('name DESC').limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end


  def self.sailboats
    includes(:classifications).where(classifications: {name: 'Sailboat'})
  end

  def self.with_three_classifications
    #binding.pry
    includes(:boat_classifications).having('COUNT(boat_classifications.boat_id) = 3').group('boat_classifications.boat_id')
  end




end
