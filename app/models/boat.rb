class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    # binding.pry
    self.limit(5)
  end

  def self.dinghy
    where("length < :length", length: 20)
  end

  def self.ship
    where("length >= :length", length: 20)
  end

  def self.last_three_alphabetically
    self.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    self.where(captain_id: nil)
  end

  def self.sailboats
    self.joins(:classifications).where(classifications:{name: 'Sailboat'})
  end

  def self.with_three_classifications
    self.joins(:classifications).group("boat_id").having("count(classification_id)=3")
  end

  def self.longest
    self.order(length: :desc).first
  end


end
