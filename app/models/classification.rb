class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    long_boat = 0
    Boat.all.each do |boat|
      if boat.length > long_boat
        long_boat = boat.length
      end
    end
    Boat.find_by(length: long_boat).classifications
  end
end
