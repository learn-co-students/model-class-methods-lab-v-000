
class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  
  def self.first_five
    all.limit(5)
  end
  
  def self.dinghy
    self.all.where("length < ?", 20)
  end
  
  def self.ship
    self.all.where("length > ?", 20)
  end
  
end


