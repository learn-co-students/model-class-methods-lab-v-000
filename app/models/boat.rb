class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    where('length < 20')
  end

  def self.ship
    where('length >= 20')
  end

  def self.last_three_alphabetically
    all.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    includes(:classifications).where(classifications: {name: 'Sailboat'})
  end

  def self.with_three_classifications
    three_class_boats = joins(:classifications).group(:boat_id).count.collect{|boat_id, count| boat_id if count == 3}.compact
    where('id IN (?)', three_class_boats)
  end

  def self.non_sailboats
    where('id NOT IN (?)', self.sailboats.pluck(:id))
  end

  def self.longest
    order(length: :desc).first
  end
end
