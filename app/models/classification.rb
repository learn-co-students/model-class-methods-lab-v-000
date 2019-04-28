class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    group("classifications.id")
  end

  def self.longest
    Boat.longest_boat.classifications
  end

end
# SELECT MAX(Price) AS LargestPrice
# maximum(:value)
# where("SELECT MAX(?)", Boat.ship.pluck(:length))

# def self.ship
#   where("length >=?", 20)
# # end
