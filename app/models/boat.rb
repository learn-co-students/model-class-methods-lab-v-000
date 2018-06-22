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
  def self.last_three_alphabetically
    last(3).sort_by { |boat| boat.name }.reverse
  end
end
