class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.group("id").limit(5)
  end

  def self.dinghy
    Boat.where(length: 1..19)
  end

  def self.ship
    Boat.where("length >= ?", 20)
  end

  def self.longest
    Boat.order("length DESC").limit(1)
  end

  def self.last_three_alphabetically
    Boat.order("name DESC").limit(3)
  end

  def self.without_a_captain
    Boat.where(captain_id: nil)
  end

  def self.sailboats
      Boat.joins(:boat_classifications, :classifications).where("classifications.name = ?", "Sailboat").uniq
  end

  def self.catamarans
      Boat.joins(:boat_classifications, :classifications).where("classifications.name = ?", "Catamaran").uniq
  end

  def self.talented
      a = Boat.joins(:boat_classifications, :classifications).where("classifications.name = ?", "Sailboat").pluck(:captain_id)
      b = Boat.joins(:boat_classifications, :classifications).where("classifications.name = ?", "Motorboat").pluck(:captain_id)
      a & b
  end


  def self.with_three_classifications
    # ugh, this is ugly
    boat_count = Boat.joins(:boat_classifications).group("boat_classifications.boat_id").count
    boats = []
    boat_count.each do |k, v|
      if v >= 3
        boats << Boat.find(k)
      end
    end
    Boat.where(id: boats)
  end
end
