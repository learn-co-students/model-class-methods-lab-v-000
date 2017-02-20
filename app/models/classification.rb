class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  class << self

    def my_all
      all
    end

    def longest
      Boat.longest.classifications
    end

  end
end
