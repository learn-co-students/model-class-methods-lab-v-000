class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all
  end

  def self.longest
    Classification.joins(:boat_classifications, :boats).where('boats.length = (SELECT MAX(boats.length) FROM boats)').uniq
  end
end
