class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    joins(:boat_classifications).select("distinct name.*").all
  end

  def self.longest
    Boat.longest
  end

end
