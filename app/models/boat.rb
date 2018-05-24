class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
  	self.all.limit(5)
  end

  def self.dinghy
  	self.all.where("length < 20")
  end

  def self.ship
  	self.all.where("length >= 20")
  end

  def self.last_three_alphabetically
  	self.all.limit(3).order("name DESC")
  end

  def self.without_a_captain
  	self.all.where(captain_id: nil)
  end

  def self.sailboats
  	self.all.joins(:classifications).where(classifications: { name: 'Sailboat' })
  end

  def self.with_three_classifications
  	self.all.joins(:classifications).group("boats.id").having("COUNT(*) = 3")
  end

  def self.longest
    self.all.order("length DESC").first
  end
end
