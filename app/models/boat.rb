class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  # t.string   "name"
  # t.integer  "length"
  # t.integer  "captain_id"

  def self.first_five
    self.limit(5)
  end

  def self.dinghy
    #returns boats shorter than 20 feet
    self.where{length < 20} #use of squeel gem
  end

  def self.ship
    #returns boats 20 feet or longer
    self.where{length > 20}
  end

  def self.last_three_alphabetically
    #returns last three boats in alphabetical order
    self.limit(3).order('name desc')
  end

  def self.without_a_captain
    #returns boats without a captain
    self.where(captain_id: [nil, ""])

  end

  def self.sailboats
    #returns all boats that are sailboats
    self.joins(:classifications).where("classifications.name = 'Sailboat'")
  end

  def self.with_three_classifications
    #returns boats with three classifications
    self.joins(:classifications).group("boats.id").having("count(boats.id) = 3")

  end

  def self.longest
    self.order('length desc').first
  end
end
