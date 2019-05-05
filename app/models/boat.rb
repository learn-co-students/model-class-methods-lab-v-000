class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    take(5)
  end

  def self.dinghy
    where("length < 20")
  end

  def self.ship
    where("length >= 20")
  end

  def self.last_three_alphabetically
    order(:name).last(3).reverse
  end

  def self.without_a_captain
    take(Boat.all.count) - self.joins(:captain)
  end

  def self.sailboats
    
  end

  def self.with_three_classifications

  end
end
