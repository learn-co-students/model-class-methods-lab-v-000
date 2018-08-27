class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.all.limit(5)
  end

  def self.dinghy
     self.having('length < 20').group(:id)
  end

  def self.ship
    self.having('length >= 20').group(:id)

  end

end
