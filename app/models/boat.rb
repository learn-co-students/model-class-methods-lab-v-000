class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

    def self.first_five
      Boat.all.select(:name).limit(5)
    end

    def self.dinghy
      Boat.all.select(:name).where(length: 0...19)
    end

    def self.ship
      Boat.all.select(:name).where(length: 20...Float::INFINITY)
    end

    def self.last_three_alphabetically
      Boat.order(name: :desc).limit(3)
    end

    def self.without_a_captain
      Boat.where(captain_id: nil)
    end

    def self.sailboats
       includes(:classifications).where(classifications: {name: "Sailboat"})
    end

    def self.with_three_classifications
    self.all.joins(:classifications).group(:boat_id).having("count(classification_id) = 3")
  end

    def self.longest
      order("length DESC").first
   
  end
end
