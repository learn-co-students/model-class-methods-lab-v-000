class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  SIZE_THRESHOLD = 20

  class << self

    def first_five
      limit(5)
    end

    def dinghy
      where("length < ?", SIZE_THRESHOLD)
    end

    def ship
      where("length >= ?", SIZE_THRESHOLD)
    end

    def last_three_alphabetically
      order(name: :desc).limit(3)
    end

    def without_a_captain
      where(captain: nil)
    end

    def sailboats
      joins(:classifications).where(classifications: {name: "Sailboat"})
    end

    def with_three_classifications
      joins(:classifications).group(:boat_id).having("COUNT(*) = 3")
    end

    def longest
      order(length: :desc).first
    end

  end
end
