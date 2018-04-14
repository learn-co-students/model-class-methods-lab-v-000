class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.all.limit(5)
  end
  def self.dinghy
    self.where('length < 20')
  end
  def self.ship
    self.where('length >= 20')
  end
  def self.last_three_alphabetically
    # binding.pry
    self.order("name").last(3)
  end
  def self.without_a_captain
    self.includes(:captain).where({captain: nil})
  end
  def self.sailboats
    self.joins(:classifications).where('classifications.name = ?', 'Sailboat')
  end
  def self.with_three_classifications
    # binding.pry
    self.joins(:classifications).having('count(classifications.name) = ?', 3).group('boats.id')
  end

end
