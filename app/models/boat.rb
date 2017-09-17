class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    firstFive = self.limit(5)
  end

  def self.dinghy
    dinghy = self.where('length < 20')
  end

  def self.ship
    ship = self.where('length > 19')
  end

  def self.last_three_alphabetically
    lastThreeAlphabetically = self.order('name desc').limit(3)
  end

end
