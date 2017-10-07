class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all
  end

  def self.longest
    joins(:boats, :boat_classifications).limit(2).order('length desc').distinct
  end

end
