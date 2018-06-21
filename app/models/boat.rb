class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
    
    def self.first_five 
        self.all.limit(5).select(:name)
    end
    
    def self.dinghy
     self.where(length: 0..20).select(:name)
    end
    
    def self.ship 
        self.where("length > 20").select(:name)
    end
    
    def self.last_three_alphabetically
        self.order(name: :desc).limit(3).select(:name)
    end
    
    def self.without_a_captain
        self.where(captain_id: nil).select(:name)
    end
    
    def self.sailboats
        self.joins(:classifications).where("classifications.name" => "Sailboat").select(:name)
    end
    
    def self.with_three_classifications
        self.joins(:classifications).group("boats.id").having("COUNT(*) = 3").select(:name)
    end
    
    def self.longest
        self.order(length: :desc).first
    end
end
