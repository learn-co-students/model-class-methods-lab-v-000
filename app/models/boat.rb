class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

# returns the first five Boats
	def self.first_five
		all.limit(5)
	end

# returns boats shorter than 20 feet
	def self.dinghy
		where("length <?", 20)
	end

# returns boats 20 feet or longer
	def self.ship
		where("length >=?", 20)	
	end

# returns last three boats in alphabetical order 
	def self.last_three_alphabetically
		all.order(name: :desc).limit(3)
	end

# returns boats without a captain 
    def self.without_a_captain
    	where("captain_id IS ?", nil)
    end

# returns boats with three classifications
	def self.with_three_classifications
    	joins(:classifications).group("boats.id").having("count(*) = 3").select("boats.*")
	end

# returns all boats that are sailboats
    def self.sailboats
    	joins(:classifications).where("classifications.name IS ?", 'Sailboat')
    end

end


