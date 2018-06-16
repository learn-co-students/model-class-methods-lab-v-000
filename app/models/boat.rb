class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  # ALSO WORKS
  #def self.first_five
  #   all.first(5)
  # end

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    all.select {|boat| boat.length < 20}
  end

  def self.ship
    all.select {|boat| boat.length > 20}
  end

  def self.last_three_alphabetically
    all.last(3).sort
  end
end
