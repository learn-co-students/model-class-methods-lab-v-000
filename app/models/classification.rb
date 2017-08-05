class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.select(:name).uniq
  end

  def self.longest
    joins(:boat_classifications, :boats).where('boats.length == 34').uniq
  end
end
