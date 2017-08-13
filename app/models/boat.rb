class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def captain_name
    if self.captain.present?
      self.captain.name
    end
  end
  
  def captain_name=(name)
    captain = Captain.find_or_create_by(name: name)
    self.captain = captain
  end

  def self.first_five
    first(5)
  end

  def self.dinghy
    where("length <?", 20)
  end

  def self.ship
    where("length >=?", 20)
  end

  def self.last_three_alphabetically
    order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    includes(:classifications).where(classifications: {name: "Sailboat"})
  end

  def self.with_three_classifications
    includes(:classifications).group("boat_id").having('COUNT(*)=3')
  end

  def self.longest
    order("length desc").first
  end

end
