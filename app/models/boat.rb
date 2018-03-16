class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def has_c(name)
    classification = Classification.find_by(name: name)
    boat.classifications.include?(classification)
  end

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    all.find_all { |boat| boat.length < 20 }
  end

  def self.ship
    all.find_all { |boat| boat.length > 20 }
  end

  def self.last_three_alphabetically
    all.order_by(name: :desc).limit(3)
  end

  def self.without_a_captain
    all.reject(&:captain)
  end

  def self.sailboats
    sailboat = Classification.find_by(name: 'Sailboat')
    all.find_all { |boat| boat.classifications.include?(sailboat) }
  end

  def self.with_three_classifications
    all.find_all { |boat| boat.classifications.size == 3 }
  end

  def self.longest
    all.order_by(length: :desc).first
  end
end
