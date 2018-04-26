class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    select(:name).limit(5)
  end

  def self.dinghy
    select(:length).where("length < ?", 20)
  end

  def self.ship
    select(:length).where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    select(:name).order(name: :desc).limit(3)
  end

  def self.without_a_captain
    select(:name).where("captain_id IS ?", nil)
  end

  def self.sailboats
    joins(:classifications).where(classifications: { name: 'Sailboat'})
  end

  def self.with_three_classifications
    joins(:classifications).group("boats.id").having('count(classification_id) = 3')
  end

  def self.longest
    order(length: :desc).limit(1)
  end

end
