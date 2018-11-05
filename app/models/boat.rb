class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    all.where("length < 20")
  end

  def self.ship
    all.where("length >= 20")
  end

  def last_three_alphabetically
    all.order(name: :desc).limit(3)
  end

  def without_a_captain
  end

end
