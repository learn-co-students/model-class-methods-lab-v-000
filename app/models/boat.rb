class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.first(5)
  end

  def self.dinghy
    self.where('length < ?', 20)
  end

  def self.ship
    self.where('length >= ?', 20)
  end

  def self.last_three_alphabetically
    self.order(name: :desc).first(3)
  end

  def self.without_a_captain
    self.where(captain_id: nil)
  end

  def self.sailboats
    self.includes(:classifications).where(classifications: { name: 'Sailboat' })
  end

  def self.with_three_classifications
    self.includes(:classifications).group("boats.id").having("Count(*) = 3")

  end

  def self.non_sailboats
    self.includes(:classifications).where.not(classifications: { name: 'Sailboat' })

    # where("id NOT IN (?)", self.sailboats.pluck(:id))
  end

  def self.longest
    self.order(length: :desc).first
  end
end
