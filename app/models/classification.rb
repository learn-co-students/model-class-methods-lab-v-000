class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.select(:name).distinct
  end

  def self.longest
    Boat.order(length: :desc).first.classifications
  end
end
