class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  def self.longest
    Boat.longest.classifications
  end
<<<<<<< HEAD
=======

>>>>>>> 7d6cc46bc457996e46d2e6c53e607d1705ff9c8a
end
