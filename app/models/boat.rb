class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    limit(5)
  end

  def self.dinghy
    where("length < 20")
  end

  def self.ship
    where("length >= 20")
  end

  def self.last_three_alphabetically
    all.order(name:"desc").limit(3)
  end

  def self.without_a_captain
    where(captain: nil)
  end

  def self.sailboats
    joins(:classifications).where("classifications.name" => "Sailboat")
  end

  def self.motorboats
    joins(:classifications).where("classifications.name" => "Motorboat")
  end


  def self.with_three_classifications
    arr = joins(:classifications).distinct.find_all do |boat|
      boat.classifications.count == 3
    end
    Boat.where(id: arr.map(&:id))
  end
end
