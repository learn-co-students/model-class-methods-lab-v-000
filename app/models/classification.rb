class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.distinct
  end

  def self.longest
    Classification.joins(:boats).merge(Boat.order(length: :desc)).limit(2)
  end
  
end
