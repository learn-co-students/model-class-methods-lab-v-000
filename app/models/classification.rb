class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    joins(boat_classifications: :boat).distinct
  end

  def self.longest
    my_all.joins(boat_classifications: :boat).group('classifications.id').having('boats.length = MAX(boats.length)')
  end

  def self.longest
    my_all.where("boats.id = #{Boat.longest.id}")
  end
end
