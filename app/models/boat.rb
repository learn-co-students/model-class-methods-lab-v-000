class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    where("length < 20" )

  end

  def self.ship
    where("length >= 20" )
  end

  def self.last_three_alphabetically
  end

  def self.without_a_captain
  end

  def self.sailboats
  end

  def self.with_three_classifications
  end

  def self.longest
  end
end
