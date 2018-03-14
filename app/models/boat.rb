class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


  	def self.first_five
  	#   returns the first five Boats (FAILED - 1)
  		all.limit(5)
      # take(5)
  	end
    
  	def self.dinghy
  #   returns boats shorter than 20 feet (FAILED - 2)
  		where('length < ?', 20)
    end

  	def self.ship
  #   returns boats 20 feet or longer (FAILED - 3)
  		where('length >= ?', 20)
    end

  	def self.last_three_alphabetically
  #   returns last three boats in alphabetical order (FAILED - 4)
  		all.order(name: :desc).limit(3)
  	end
  	def self.without_a_captain
  #   returns boats without a captain (FAILED - 5)
  		# binding.pry
  		where(captain_id: nil)
  	end
  	def self.sailboats
  #   returns all boats that are sailboats (FAILED - 6)
  		# binding.pry
  		includes(:classifications).where(classifications: {:name => 'Sailboat'})
  	end

  	def self.with_three_classifications
      # binding.pry
  #   returns boats with three classifications (FAILED - 7)
  		joins(:classifications).group("boats.id").having("COUNT(*) = 3")
  	end

    def self.longest
      order('length DESC').first
    end
end
