class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.limit(5)
  end

  def self.dinghy
    self.limit(20).where("length < ? ", 20)
  end

  def self.ship
    self.where("length >= ? ", 20)
  end

  def self.last_three_alphabetically
    self.limit(3).order(name: :desc)
  end

  def self.without_a_captain
    self.where(captain: nil)
  end

  def self.sailboats
    # binding.pry
    Classification.find_by(name: 'Sailboat').boats
  end

  def self.with_three_classifications
    self.joins(:classifications).group('boats.id').having('count(boat_id) = 3')
  end
end
