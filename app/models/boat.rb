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
    includes(:captain).where(captain: nil)
  end

  def self.sailboats
    includes(:classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.with_three_classifications
    includes(:classifications).find_each do |classification|
      classification.where(classification.count == 3)
    end
  end
end
