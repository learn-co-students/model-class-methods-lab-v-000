class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  def self.longest
    includes(:boats).where('boats.length = (SELECT MAX(length) from boats)')
  end
end
