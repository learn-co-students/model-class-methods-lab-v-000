class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    where("length < ?", 20)
  end

  def self.ship
    where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    all.order(:name).reverse_order.limit(3)
  end

  def self.without_a_captain
    where("captain_id is null") # can't use captain_id = nil because db uses three-value logic; null is neither true not false, can't be stated as 'equal to'
  end

  def self.sailboats
    joins(:classifications).where("classifications.name = ?", "Sailboat")
  end

  def self.with_three_classifications
    joins(:classifications).group(:boat_id).having("COUNT(*) = 3")
  end
end
