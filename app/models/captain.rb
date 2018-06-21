class Captain < ActiveRecord::Base
  has_many :boats
    
    def self.catamaran_operators 
         self.joins(boats: :classifications).where("classifications.name" => "Catamaran").select(:name)
    end
    
    def self.sailors 
        self.joins(boats: :classifications).where("classifications.name" => "Sailboat").select(:name).uniq
    end
    
    def self.talented_seafarers
        self.joins(boats: :classifications).group("classifications.name").having("classifications.name IN ('Sailboat', 'Motorboat')").order(:name)
    end
    
    def self.non_sailors 
        self.where.not(name: self.sailors)
    end
end
