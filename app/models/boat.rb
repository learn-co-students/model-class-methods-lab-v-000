class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


  def self.first_five
    self.limit(5)
  end

  def self.dinghy
    self.where(:length => [0..19])
  end

  def self.ship
    self.where("length > ?", 20)
  end

  def self.last_three_alphabetically
    self.order("name desc").limit(3)
  end

  def self.without_a_captain
    self.where("captain_id is NULL")
  end

  def self.sailboats
    binding.pry
    self.classifications.where("name is sailboats")
  end

end
