class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    order('id').limit(5)
  end

  def self.dinghy
    where("length <= '20'")
  end

  def self.ship
    where("length >= '20'")
  end

  def self.last_three_alphabetically
    order('name').reverse_order.limit(3)
  end

  def self.without_a_captain
    where(captain: nil)
  end

  def self.sailboats
    includes(:classifications).where(classifications: {name: "Sailboat"}).references(:classifications)
  end

  def self.catamarans
    includes(:classifications).where(classifications: {name: "Catamaran"}).references(:classifications)
  end

  def self.with_three_classifications
    includes(:classifications).group(:boat_id).having('count(classification_id) = ?', 3)
  end

  def self.longest
    all.max_by(&:length)
  end
end
