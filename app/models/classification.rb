class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  
  def self.my_all
    select(:name)
  end


  def self.longest
    joins(:boats).where('boats.length = ?',  Classification.joins(:boats).maximum('boats.length'))
  end
end
