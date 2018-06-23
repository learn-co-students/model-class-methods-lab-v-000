class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    limit(5)
  end

  def self.dinghy
    where("length <= 20")
  end

  def self.ship
    where("length >= 20")
  end

  # works in console
  # Error: boat_spec: undefined method `pluck' for ["Sunfish", "Sun Tracker Regency 254 XP3", "Harpoon 4.7"]:Array
  def self.last_three_alphabetically
    last(3).map! { |boat| boat.name }.sort.reverse
  end
end
