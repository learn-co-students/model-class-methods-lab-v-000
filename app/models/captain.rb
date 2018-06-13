class Captain < ActiveRecord::Base
  has_many :boats

   def self.catamaran_operators
      joins(boats: [:classifications]).where("classifications.name = 'Catamaran'").uniq
    end

    def self.sailors
      joins(boats: [:classifications]).where("classifications.name = 'Sailboat'").uniq
    end

    def self.talented_seafarers
      joins(boats: [:classifications]).group("classifications.name").having("classifications.name IN ('Sailboat', 'Motorboat')").order("captains.name")
    end

    def self.non_sailors
      where.not("id IN (?)", self.sailors.pluck(:id))
    end
  
end
