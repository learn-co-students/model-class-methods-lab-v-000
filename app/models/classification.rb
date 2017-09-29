class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
  	all
  end

  def self.longest
  	includes(:boats).order('boats.length DESC').limit(1)
  end
end
