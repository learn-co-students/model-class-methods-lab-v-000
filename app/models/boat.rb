class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

def self.first_five
  #binding.pry
  Boat.all.limit(5)
end 

def self.dinghy 
  #binding.pry
  Boat.where(Boat.arel_table[:length].lt(20))
end 

def self.ship
  Boat.where(Boat.arel_table[:length].gteq(20))
end 

def self.last_three_alphabetically
  Boat.order(Boat.arel_table[:name].desc).limit(3)
end 

def self.without_a_captain
  #binding.pry
  Boat.where(Boat.arel_table[:captain_id].eq(nil))
end 

def self.sailboats
  #binding.pry
  #Boat.where(Boat.arel_table[:classifications][:name].eq("sailboat"))
  #Boat.join(boats.join(boat_id, Arel::Nodes::OuterJoin).on(boat_classifications[:boat_id])
  #Boat.join(Boat.arel_table).on(boats[:id].eq(boat_classifications[:boat_id]).where(BoatClassifications.arel_table[:boat_id].eq(1))
  Boat.includes(:classifications).where(classifications:{name: "Sailboat"})
end 

def self.with_three_classifications
  #binding.pry
  #Boat.where(Boat.arel_table[:classications].count(3))
  #Boat.includes(:classifications).having(classifications.count(3))
  Boat.joins(:classifications).group(:boat_id).having("count(*)=3")

end 


end
