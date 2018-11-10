class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    # first five boats
    self.limit(5)
  end

  def self.dinghy
    # boats shorter than 20 feet
    self.where("length < ?", 20)
  end

  def self.ship
    # boats 20 feet or longer
    self.where.not("length < ?", 20)
  end

  def self.last_three_alphabetically
    # last three boats in alphabetical order
    self.order("name DESC").limit(3)
  end

  def self.without_a_captain
    # boats without a captain
    self.where(captain_id: nil)
  end

  def self.sailboats
    #self.joins(:classifications).where(classifications: {name: 'Sailboat'})
    self.joins(:classifications).where('classifications.name = ?', 'Sailboat')
  end

  def self.with_three_classifications
    self.joins(:classifications).order("boat_id").group("boat_id").having("count
(boat_id) = ?", 3)
    # boats_classification = self.joins(:classifications).order("boat_id").group("boat_id").count
    # boats_classification.collect do |boat|
    #   Boat.find(boat[0]) if boat[1] == 3
    # end
  end

  def self.longest
    # longest boat
    self.order("length ASC").last
  end
end
