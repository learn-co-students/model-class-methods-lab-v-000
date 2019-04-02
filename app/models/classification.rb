class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.select_classifications(classification)
    find_by(:name => classification)
  end

  def self.select_boats(classification)
    @classification = select_classifications(classification)
    @classification.boats
  end

  def self.my_all
    Classification.all
  end

  def self.longest
    Boat.longest.classifications
  end
end
