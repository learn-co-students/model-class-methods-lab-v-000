class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  
  def self.my_all
    self.all
  end
  
  def self.longest
    self.order(length: :desc).first.classifications
  end
end
