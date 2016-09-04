class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  # def self.all
  #   @boats = Boat.all
  # end

  def self.first_five
    limit(5)
  end

  def self.dinghy
    where(length: 0..20)
  end

  def self.ship
    where('length > ?', 20)
  end

  def self.last_three_alphabetically
    limit(3).order(name: :desc)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
     joins(:classifications).where('classifications.name' => "Sailboat")
  end

  def self.with_three_classifications
    joins(:classifications).group("boats.name").having("count(boat_id) = 3")
  end


end
