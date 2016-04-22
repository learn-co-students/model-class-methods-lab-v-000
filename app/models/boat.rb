class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.all.limit(5)
  end

  def self.dinghy
    self.where("length < ?", 20)
  end

  def self.ship
    self.where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    self.order("name DESC").limit(3)
  end

  def self.without_a_captain
    self.where("captain_id IS NULL")
  end

  def self.sailboats
    #sailboat_id = Classification.find_by(name: "Sailboat").id
    #self.joins(:boat_classifications).where("classification_id = ?", sailboat_id)
    self.joins(:classifications).where("classifications.name = ?", "Sailboat")
  end

  def self.with_three_classifications
    self.joins(:classifications).group("boat_id").having("COUNT(*) = ?", 3)
  end

  #helper method for Classification.longest
  def self.longest
    self.order("length").last
  end

end
