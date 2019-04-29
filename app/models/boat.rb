class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    select(:name).limit(5)
  end

  def self.dinghy
    where("length < ?", 20)
  end

  def self.ship
    where("length > ?", 20)
  end

  def self.last_three_alphabetically
    select(:name).order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where('captain_id IS NULL')
  end

  def self.sailboats
    # binding.pry
    # includes('classifications').where(name: sailboat)
    where(classifications: { name: 'Sailboat' })
  end
end
