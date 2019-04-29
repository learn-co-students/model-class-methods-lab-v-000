class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.max_length
    self.joins(:boats).maximum(:length)
  end

  def self.longest
    self.joins(:boats).where("length = ?", self.max_length)
  end

end
