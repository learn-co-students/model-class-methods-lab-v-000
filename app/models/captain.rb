class Captain < ActiveRecord::Base
  has_many :boats

# returns all captains of catamarans
	def self.catamaran_operators
		includes(boats: :classifications).where(classifications: {name: 'Catamaran'})
	end
# returns captains with sailboats
	def self.sailors
		sailor_ids = Boat.sailboats.pluck(:captain_id).compact.uniq
		where(id: sailor_ids)
	end
# returns captains of motorboats and sailboats
	def self.talented_seafarers
		where("id IN (?)", includes(boats: :classifications).where(classifications: {name: 'Motorboat'}).pluck(:id) & self.sailors.pluck(:id))

	end
# returns people who are not captains of sailboats
	def self.non_sailors
		where.not(id: self.sailors.pluck(:id))
	end
end


    def self.sailboats
    	joins(:classifications).where("classifications.name IS ?", 'Sailboat')
    end