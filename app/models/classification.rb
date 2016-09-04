class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    # SELECT * FROM Classification
    all
  end

  def self.longest
    # joins(:boats).where('boats'.order(length: :desc)),  limit(1)
    includes(:boats).where('boats.length = (SELECT MAX(length) from boats)')
  end
end
