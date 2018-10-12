class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.limit(5)
  end

  def self.dinghy
    where("length < 20")
  end

  def self.ship
    where("length > 20")
  end

  def self.last_three_alphabetically
    self.limit(3).order('name desc')
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    self.includes(:classifications).where('classifications.name = ?', 'Sailboat')
  end

  def self.with_three_classifications
    self.joins(:classifications).having('COUNT(classification_id) = 3').group('boat_id')
  end
end
