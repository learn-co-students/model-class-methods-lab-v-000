class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    where("length < 20")
  end

  def self.ship
    where("length >= 20")
  end

  def self.longest_length
    Boat.order(length: :desc).limit(1)[0].length
  end

  def self.longest
    Boat.where(length: Boat.longest_length)
  end

  def self.last_three_alphabetically
    Boat.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    includes(:classifications).where(classifications: { name: 'Sailboat' })
    # Boat.joins(:classifications).where("classifications.name = ?", "Sailboat")
  end

  def self.catamarans
    includes(:classifications).where(classifications: { name: 'Catamaran' })
  end

  def self.motorboats
    includes(:classifications).where(classifications: { name: 'Motorboat' })
  end

  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")

    # array = []
    # Boat.all.each do |boat|
    #   if boat.classifications.size == 3
    #     array << boat.id
    #   end
    # end
    # Boat.where(id: array)
  end

end
