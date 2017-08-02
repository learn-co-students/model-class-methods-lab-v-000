class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  extend ArelTables

  def self.my_all
    self.all
  end

  def self.longest
    self.joins(:boats).where(boats_arel[:length].eq(Boat.maximum(:length)))
  end
  
end
