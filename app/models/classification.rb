class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all.select(:name)
  end

  def self.longest
    Boat.all.order(length: :desc).limit(1)[0].classifications
  end

end
