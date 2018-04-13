class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end
  def self.longest
    # binding.pry
    self.joins(:boats).where('boats.length >' => 20)
  end
end
