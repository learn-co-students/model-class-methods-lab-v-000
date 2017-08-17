class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.sailboat
    self.find_by_name("Sailboat").id
  end

  def self.catamaran
    self.find_by_name("Catamaran").id
  end

  def self.motorboat
    self.find_by_name("Motorboat").id
  end

  def self.my_all
    self.all
  end

  def self.longest
    Boat.order(length: :desc).limit(1).first.classifications
  end

end
