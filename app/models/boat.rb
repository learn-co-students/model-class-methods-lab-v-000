class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.all.limit(5)
  end

  def self.longest
    Boat.order(length: :desc).first
  end

  def self.dinghy
    Boat.where("length < 20")
  end

  def self.ship
    Boat.where("length > 19")
  end

  def self.last_three_alphabetically
    Boat.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    Boat.where(captain_id: nil)
  end

  def self.sailboats
    Classification.find_by(name: "Sailboat").boats
  end

  def self.with_three_classifications
    joins(:classifications).group('boats.id').having('COUNT(*) = 3')
  end

end
