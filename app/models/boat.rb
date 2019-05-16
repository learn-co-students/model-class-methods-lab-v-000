class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    #Boat.find(:all, :order => "boat_id", :limit => 5)
    Boat.first(5)
  end

  def self.dinghy
    Boat.where( "length < ?", 20)
  end

  def self.ship
    Boat.where( "length > ?", 20)
  end

end
