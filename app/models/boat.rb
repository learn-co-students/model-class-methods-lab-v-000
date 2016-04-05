class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.limit(5)
  end

  def self.dinghy
    self.where("length < ?", 20)
  end

  def self.ship
    self.where("length > ?", 20)
  end

  def self.last_three_alphabetically
    self.order("name DESC").limit(3)
  end

  def self.without_a_captain
    self.where(captain_id: nil)
  end

  def self.sailboats
    self.joins(:classifications).where("classifications.name = ?", "Sailboat")
  end

  def self.with_three_classifications
    boat_ids_with_classifications = self.joins(:classifications).group(:boat_id).count
    boats_with_three_classifications = boat_ids_with_classifications.select { |boat_id, class_number| class_number == 3 }
    boat_ids = boats_with_three_classifications.keys
    self.where(id: boat_ids)
  end


end
