class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.limit(5).order("id asc")
  end

  def self.dinghy
    where("length<?", 20)
  end

  def self.ship
    where("length>=?", 20)
  end

  def self.last_three_alphabetically
    self.limit(3).order("name desc")
  end

  def self.without_a_captain
    where("captain_id IS NULL")
  end

  def self.sailboats
    self.joins(:classifications).where("classifications.name==?", "Sailboat")
  end

  def self.with_three_classifications
    self.joins(:classifications).having("COUNT(*)==3").group("boat_id")
  end

  def self.longest
    self.where("length == ?", Boat.maximum("length"))
  end

  def self.sailboat_or_motorboat
    self.joins(:classifications).where(classifications: ({name: "Sailboat"} & {name: "Motorboat"}))
  end

end
