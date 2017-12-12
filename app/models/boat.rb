class Boat < ActiveRecord::Base

  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    first_five_boats = self.limit(5).order('id asc')
  end

  def self.dinghy
    self.where("length < 20")
  end

  def self.ship
    self.where("length > 20")
  end

  def self.last_three_alphabetically
    last_3 = self.order("name desc").limit(3)
  end

  def self.without_a_captain
    self.where(captain_id: nil)
  end

  def self.sailboats
    self.joins(:classifications).where(:classifications => {:name => "Sailboat"})
  end

  def self.with_three_classifications
    self.joins(:classifications).group("boat_classifications.boat_id").having("COUNT(boat_classifications.classification_id) == 3")
  end
end
