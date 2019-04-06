class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    where('length < 20')
  end

  def self.ship
    where('length >= 20')
  end

  def self.last_three_alphabetically
    a = all.sort_by {|obj| obj.name}.last(3).reverse
  end

  def self.without_a_captain
    array = []
    all.each do |boat|
      if !boat.captain.present?
        array << boat
      end
    end
    array
  end

  def self.sailboats
    array = []
    all.each do |boat|
      if boat.classifications.find {|clas| clas.name == "Sailboat"}
        array << boat
      end
    end
    array
  end

  def self.with_three_classifications
    array = []
    all.each do |boat|
      if boat.classifications.count == 3
        array << boat
      end
    end
    array
  end
end
