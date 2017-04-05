class Classification < ActiveRecord::Base
    has_many :boat_classifications
    has_many :boats, through: :boat_classifications

    def self.my_all
        Classification.all
    end

    def self.longest
#        max_length = Boat.order("length DESC").first
#        Classification.joins(:boats).where("length = ?", max_length.length)
        Boat.order(length: :desc).first.classifications
    end
end
