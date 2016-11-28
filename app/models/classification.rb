class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
<<<<<<< HEAD

  def self.my_all
    all
  end

  def self.longest
    Classification.includes(:boats).where(boats: {length: Boat.maximum("length")})
  end
=======
>>>>>>> 4971cb53f290a9e7272e339aeb997b5c1f31444a
end
