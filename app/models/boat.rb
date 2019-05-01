class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    boats = Boat.first(5)
  end

  def self.dinghy
    boat = Boat.where("length < 20")
  end

  def self.ship
    boat = Boat.where("length >= 20")
  end

  def self.last_three_alphabetically
    boats = Boat.order(:name).last(3)
    boats.sort
  end

  def self.without_a_captain
    boats = Boat.where("captain_id is null")
  end

  def self.sailboats
    boats = Boat.includes(:classifications).where("classifications.name = ?", 'Sailboat').references(:classifications)
  end

  def self.with_three_classifications
    @boats = []
    Boat.includes(:classifications).each do |boat|
      if boat.classifications.count == 3
        @boats << boat
      end
    end
    @boats 
  end
end
