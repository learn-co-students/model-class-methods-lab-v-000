class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    take(Classification.all.count)
  end

  def self.longest
    Boat.ship.order(:length).last.classifications.each { |c| c.name }
  end
end
