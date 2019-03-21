class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  # def self.longest
  #
  # end

def self.longest
  # binding.pry

  # Boat.order(length: :desc).limit(1)
  # self.joins(:boats_id).where(length: (Boat.maximum('length'))).classifications
  # binding.pry
  # self.includes(:boats).where(length: 34)
  # self.joins(:boats).group("boats.id").having("COUNT(*) = 3")
  # self.joins(:boats).group("boats.id")
  # Boat.where(length: 34).classifications
# self.joins(:boats).order(length: :desc).limit(1)
# Boat.order(length: :desc).limit(1)

    Boat.longest.classifications
end

end
