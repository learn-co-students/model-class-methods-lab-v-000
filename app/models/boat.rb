class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    first_five = self.first.id + 4
    where("id <=?", first_five)
    # binding.pry

  end

  def self.dinghy
    where("length <?", 20)
  end

  def self.ship
    where("length >=?", 20)
    # binding.pry
  end

  def self.last_three_alphabetically
    # list = self.alphabetical
    order(name: :desc).limit(3)
    # binding.pry
  end

# TODO: Return to this
  def self.without_a_captain
    where(captain: nil)
  end

  def self.sailboats
    includes(:classifications).where('classifications.name = ?', 'Sailboat').references(:classifications)
    # binding.pry
  end

  def self.motorboats
    includes(:classifications).where('classifications.name = ?', 'Motorboat').references(:classifications)
    # binding.pry
  end

  def self.with_three_classifications
    includes(:boat_classifications).having("COUNT(classification_id) = 3").group('boat_id')
  end

end
