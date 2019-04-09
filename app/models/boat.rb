class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications



  #def boats
    #Boat.arel_table
  #end

  def self.first_five
    Boat.all.limit(5)
    #boats = Boat.arel_table
    #f_f = Boat.select(boats[:name]).where(boats[:id].lteq(5))
    #f_f #>undefined method for array
  end

  def self.dinghy
    Boat.where("length < 20")
  end

  def self.ship
    Boat.where("length >= 20")
  end

  def self.last_three_alphabetically
    Boat.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    Boat.where("captain_id IS NULL")
  end

  def self.sailboats
    boats = Boat.arel_table
    Boat.select("boats.*").includes(:classifications).where(classifications: {name: "Sailboat"})
  end

end
