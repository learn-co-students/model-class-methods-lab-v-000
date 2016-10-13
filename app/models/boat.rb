class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


  def self.first_five
    self.limit(5)
  end

  def self.dinghy
    self.where(:length => [0..19])
  end

  def self.ship
    self.where("length > ?", 20)
  end

  def self.last_three_alphabetically
    self.order(:name).last(3)
  end

end
