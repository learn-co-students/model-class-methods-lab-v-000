class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.order(created_at: :asc).limit(5)
  end

  def self.dinghy
    self.where("length < 20")
  end

  def self.ship
    self.where("length > 20")
  end

  def self.last_three_alphabetically
    self.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    self.where(captain: nil)
  end

  def self.sailboats
    joins(:classifications).where("classifications.name == ?", "Sailboat")
  end

  def self.with_three_classifications
    joins(:boat_classifications).having('COUNT(boat_classifications.classification_id) > 2').group('boat_id')
  end

  def self.longest
    order('length DESC').first
  end

end
