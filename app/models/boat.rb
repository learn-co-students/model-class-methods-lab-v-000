class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    limit(5)
  end

  def self.dinghy
    where("length <?", 20)
  end

  def self.ship
    where("length >=?", 20)
  end

  def self.last_three_alphabetically
    order('name DESC').limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    joins(:classifications).where(:classifications => {:name => "Sailboat"})
  end

  def self.with_three_classifications
    joins(:boat_classifications).group(:boat_id).having('count(classification_id) =?', 3)
    # joins(:boat_classifications).group(:'classification_id').having('count(classification_id)>2')
  end

  def self.order_length
    joins(:classifications).group(:name).order("length DESC").limit(2)
  end
end
