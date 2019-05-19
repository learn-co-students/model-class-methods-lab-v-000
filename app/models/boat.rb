class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.all[0..4]
  end

  def self.dinghy
    self.all.select { |boat| boat.length < 20 }
  end

  def self.ship
    self.all.select { |boat| boat.length >= 20 }
  end

  def self.last_three_alphabetically
    self.all.sort_by { |boat| boat.name }.last(3).reverse
  end

  def self.without_a_captain
    self.all.select { |boat| boat.captain.nil? }
  end

  def self.sailboats
    self.all.select { |boat| boat.classifications.find_by(name: "Sailboat") }
  end

  def self.with_three_classifications
    self.all.select { |boat| boat.classifications.length == 3 }
  end
end
