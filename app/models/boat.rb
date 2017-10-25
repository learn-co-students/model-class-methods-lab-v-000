class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.first(5)
  end

  def self.dinghy
    Boat.where("length < 20")
  end

  def self.ship
    Boat.where("length > 20")
  end

  def self.last_three_alphabetically
    Boat.last(3).sort_by{|boat|boat.name}
  end

  def self.without_a_captain
    Boat.where(captain_id: nil)
  end


  def self.sailboats
    Boat.includes(:classifications).where('classifications.name = ?', 'Sailboat').references(:classifications)
  end

  def self.boat_type(boat)
     Boat.includes(:classifications).where('classifications.name = ?', boat).references(:classifications)
  end

  def self.with_three_classifications
    Boat.joins(:classifications).group('boats.id').having('count(boat_id) = 3')
  end

end
