class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    select(:classifications)
  end

  def self.longest
    select(:boats).where("id IN (?)", longest_boat_classifications)
  end

  private

  def self.longest_boat_classifications
    Boat.all.sort{|x, y| y.length <=> x.length}.first.classifications.map do |classification|
      classification.id
    end
  end
end
