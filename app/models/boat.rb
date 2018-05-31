class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    where("length < ?", 20)
  end

  def self.ship
    where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    all.limit(-3).order("name")
  end

  def self.without_a_captain
    where(captain: nil)
  end

  def self.sailboats
    where(classifications: "sailboat")
  end

  def self.with_three_classifications
    all.find_all{|b| b.classifications.count == 3}
  end

end
