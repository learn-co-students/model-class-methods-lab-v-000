class Captain < ActiveRecord::Base
    has_many :boats

    def self.catamaran_operators
        
        Captain.select("captains.*").joins(boats: :classifications).where("classifications.name = ?","Catamaran")    
    end

    def self.sailors
        Captain.select("captains.*").distinct.joins(boats: :classifications).where("classifications.name = ?","Sailboat")    
    end

    def self.motorboat_captains
       Captain.select("captains.*").joins(boats: :classifications).where("classifications.name = ?","Motorboat") 
    end
    def self.talented_seamen
        #Need to find the intersection of:
#        Captain.select("captains.*").joins(boats: :classifications).where("classifications.name = ?","Sailboat") 
#        Captain.select("captains.*").joins(boats: :classifications).where("classifications.name = ?","Motorboat")
        where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_captains.pluck(:id))
        
    end

    def self.non_sailors
        where.not("id IN (?)", self.sailors.pluck(:id))
    end

end
