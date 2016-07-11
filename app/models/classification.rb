class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    c = BoatClassification.arel_table
    self.joins(:boat_classifications).where(c[:boat_id].matches(Boat.longest_id))
  end

end
