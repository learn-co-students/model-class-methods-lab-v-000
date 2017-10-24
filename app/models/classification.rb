class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    maximum_boat_length = Boat.maximum('length')

    self.joins(:boat_classifications, :boats).where("boat_classifications.boat_id = boats.id").where("boats.length = #{maximum_boat_length}")
  end
end
