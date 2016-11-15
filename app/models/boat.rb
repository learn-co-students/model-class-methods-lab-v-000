class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five # returns the first five Boats
    self.limit(5)
  end

  def self.dinghy # returns boats shorter than 20 feet
    self.where('boats.length < ?', 20)
  end

  def self.ship # returns boats 20 feet or longer
    self.where('boats.length > ?', 20)
  end

  def self.last_three_alphabetically # returns last three boats in alphabetical order
    self.order(name: :desc).limit(3)
  end

  def self.without_a_captain # returns boats without a captain
    self.where(captain: nil)
  end

  def self.sailboats # returns all boats that are sailboats
    Classification.find_by(name: "Sailboat").boats
  end

  def self.with_three_classifications # returns boats with three classifications
    self.joins(:classifications).group("boat_id").having("count(*) = ?", 3)
  end

  def self.longest
    self.order(length: :desc).first
  end

  def self.sailboats
    self.joins(:classifications).where('classifications.name = ?', 'Sailboat')
  end
end
