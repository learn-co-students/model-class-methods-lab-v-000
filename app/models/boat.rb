class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.limit(5)
  end

  def self.dinghy
    Boat.where('length < ?', 20)
  end

  def self.ship
    Boat.where('length > ?', 20)
  end

  def self.last_three_alphabetically
    Boat.limit(3).order(name: :desc)
  end

  def self.sailboats
    Boat.includes(:classifications).where(:classifications => {:name => 'Sailboat'}).all

  end

  def self.without_a_captain
    Boat.where(:captain_id => nil).all
  end

  def self.with_three_classifications
    Boat.joins(:classifications).group("boat_id").having("count(*) >= 3")
  end

end
