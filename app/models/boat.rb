class Boat < ActiveRecord::Base
# t.string  :name
# t.integer :length
# t.integer :captain_id
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

# returns the first five Boats
  def self.first_five
    Boat.all.limit(5)
  end

# returns boats shorter than 20 feet
  def self.dinghy
    Boat.where("length < ?", 20)
  end

# returns boats 20 feet or longer
  def self.ship
    Boat.where("length >= ?", 20)
  end

# returns last three boats in alphabetical order
  def self.last_three_alphabetically
    Boat.order('name DESC').limit(3)
  end

# returns boats without a captain
  def self.without_a_captain
    Boat.where(:captain => nil)
  end

# returns all boats that are sailboats
  def self.sailboats
    Classification.where(:name => 'Sailboat').first.boats
  end

# returns boats with three classifications
  def self.with_three_classifications
    boats = Boat.all.select do |boat|         #returns array needs to return activerecord relation?
      boat.classifications.size == 3
    end

    Boat.where(id: boats.map(&:id))
  end
end
