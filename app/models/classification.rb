class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  def self.longest
    Boat.joins(:boat_classifications, :classifications).order(length: :desc).limit(1).first.classifications    # joins(:boat_classifications, :boats).order(length: :asc).limit(1).classifications
  end
end
