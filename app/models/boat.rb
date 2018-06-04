class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  	def self.first_five
  		Boat.limit(5)
  	end

  	def self.dinghy
  		Boat.where("length <?", 20)
  	end

  	def self.ship
  		Boat.where("length >=?", 20)
  	end

  	def self.last_three_alphabetically
  		
  		Boat.order(:name).reverse_order.limit(3)
  	end

  	def self.without_a_captain
  		Boat.where(captain_id: nil)

  	end

  	def self.sailboats
  		Boat.includes(:classifications).where(classifications: {name: "Sailboat"})
  	end

    def self.with_three_classifications
    	joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
    end

    def self.longest
    	order('length DESC').first
    end

end


# Boat::sailboats returns all boats that are sailboats