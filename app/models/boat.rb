class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    # names = Boat.all.map{|b| b }[0 .. 4]
    all.limit(5)
  end

  def self.dinghy
    where("length < 20")
  end

  def self.ship
    where("length >= 20")
  end

  def self.last_three_alphabetically
    # all.sort_by{|b| b.name.downcase}.last(3)
    all.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where("captain_id == nil")
  end

  def self.sailboats
  end

  def self.with_three_classifications
  end


end
