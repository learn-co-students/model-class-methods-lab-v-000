class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  scope :with_boats, ->{joins(:boats)}
  
  def self.my_all
    select(:name).distinct
  end 

  def self.longest
    #max_length = with_boats.select('MAX(boats.length)')
    with_boats.where("boats.length = ?", with_boats.maximum('length'))
  end 
  
end
