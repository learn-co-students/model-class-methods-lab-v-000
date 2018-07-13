class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.first(5)
  end

  def self.dinghy
    self.where("length < ?", 20)
  end

  def ship
    self.where("length > ?", 20)
  end

end
