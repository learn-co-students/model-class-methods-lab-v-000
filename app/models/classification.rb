class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  
  def self.my_all
    all.distinct
  end
  
  def self.longest
    includes(:boats).order("boats.length DESC").distinct.limit(2)
  end
end
