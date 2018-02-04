class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  class << self
    
    def my_all
      self.all
    end

    def longest
      joins(:boats).order("length DESC").limit(2)
    end
  end
end
