class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    # returns the first five Boats
    # boats = Boat.all.map {|boat| boat.name if boat.id <= 5}.compact
    # binding.pry
    Boat.all.limit(5)
  end

  def self.dinghy
    # Boat.all.map {|boat| boat.name if boat.length < 20}.compact
    Boat.where("length < 20")
  end

  def self.ship
    Boat.where("length >= 20")
  end

  def self.last_three_alphabetically
    Boat.order(:name).reverse_order.limit(3)
  end

  def self.without_a_captain
    Boat.where(captain_id: nil)
  end

  def self.sailboats
    Boat.includes(:classifications).where('classifications.name = ?', 'Sailboat').references(:classifications)
  end

  def self.with_three_classifications
    Boat.joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
  end

  # helper method for #Classification.longest
  def self.longest
    Boat.order('length DESC').first
  end
end
