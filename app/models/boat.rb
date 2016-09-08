class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.all.limit(5)
  end

  def self.dinghy
    Boat.all.where("length < 20")
  end

  def self.ship
    Boat.all.where("length >= 20")
  end

  def self.last_three_alphabetically
    Boat.all.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    Boat.all.where(captain_id: nil)
  end

  def self.sailboats
    # learn.co answer:
    # Boat.includes(:classifications).where(classifications: { name: 'Sailboat' })
    Boat.joins(:classifications).where(classifications: {name: "Sailboat"})
  end

  def self.motorboats
    # learn.co answer:
    # Boat.includes(:classifications).where(classifications: { name: 'Sailboat' })
    Boat.joins(:classifications).where(classifications: {name: "Motorboat"})
  end


  def self.with_three_classifications
    # http://stackoverflow.com/questions/20183710/find-all-records-which-have-a-count-of-an-association-greater-than-zero
    Boat.joins(:classifications).group('boats.id').having('count(boat_id) = 3')
  end

  def self.longest
    order('length DESC').first
  end

end
