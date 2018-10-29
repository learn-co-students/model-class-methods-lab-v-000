class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    order(:id).limit(5)
  end

  def self.dinghy
    where(length: [0..19])
    # where("length < 20")
  end

  def self.ship
    where.not(length: [0..19])
    # where("length >= 20")
  end

  def self.last_three_alphabetically
    order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    # joins(:classifications).merge( Classification.where(name: "Sailboat") )
    includes(:classifications).where(classifications: { name: 'Sailboat' })
  end

  def self.catamarans
    # joins(:classifications).merge( Classification.where(name: "Catamaran") )
    includes(:classifications).where(classifications: { name: 'Catamaran' })
  end

  def classifications_count
    classifications.count
  end

  def self.with_three_classifications
    # joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")

    three = []
    self.all.each do |boat|
      if boat.classifications_count >= 3
        three << boat
      end
    end
    three
  end

  def self.longest
    all.order(length: :desc).limit(1)
  end
end
