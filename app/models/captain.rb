class Captain < ActiveRecord::Base
    has_many :boats
    
    def self.catamaran_operators
        self.all.includes(boats: :classifications).where(classifications: {name: "Catamaran"}).uniq
    end
    
    def self.sailors
        self.all.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
    end
    
     def self.motorboaters
        self.all.includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
    end
    
    def self.talented_seafarers
        sailors = self.sailors.pluck(:id)        
        motorboaters = self.motorboaters.pluck(:id)
        
        self.where("id IN (?)", sailors & motorboaters)
    end
    
    def self.non_sailors
        sailors = self.sailors.pluck(:id)        
        
        self.where.not("id IN (?)", sailors).uniq
    end
        
end
