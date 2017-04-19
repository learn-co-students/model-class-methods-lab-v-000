class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    where("name != ''")
  end

  def self.longest
    joins(:boats).where("length == (?)", Boat.maximum("length"))
  end
end
