class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    where("length <= ?", 20)
  end

  def self.ship
    where("length > ?", 20)
  end

  def self.longest
    all.order(length: :desc).first
  end

  def self.last_three_alphabetically
    all.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    includes(:classifications).where('classifications.name = ?', 'Sailboat')
  end

  def self.with_three_classifications
    includes(:classifications).group('boat_id').having('COUNT(classification_id) = ?', 3)
  end

end
