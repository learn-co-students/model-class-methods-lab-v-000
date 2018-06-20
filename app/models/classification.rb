class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.longest
    longest = joins(:boats).merge(Boat.order("length DESC")).first
  end

  def self.my_all
    self.all
  end
  
  def self.longest
    Boat.longest.classifications
  end

end


# .select("length")

# Classification.all.joins(:boats).merge(Boat.where("length == ?", longest.length))
# Boat.
