class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    uniq
  end

  def self.longest
    Boat.order(length: :desc).limit(1).first.classifications
  end
end
