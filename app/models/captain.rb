class Captain < ActiveRecord::Base
  has_many :boats


  def self.catamaran_operators
    arr = Classification.find_by(name: "Catamaran").boats.map {|f| f.captain}
    self.where(id: arr.map(&:id))

    #can only go through boats.  need to get to classification.

    # Boat.joins(:boat_classifications).group(:boat_id).having("count(boat_id) = ?", 3)

    # binding.pry
    # Classification.joins(:boat_classifications).find_by(name: "Catamaran").boats
    # binding.pry
    # Classification.find_by(name: "Catamaran").boats.joins(:captain)

    # Classifcation.joins(:boat_classifications).joins(:captains)


  end

  def self.sailors
    arr = Classification.find_by(name: "Sailboat").boats.map {|boat| boat.captain}.compact
    self.where(id: arr.map(&:id))

  end

  def self.talented_seamen
    binding.pry
    Classification.where("name = ? OR name = ?", "Sailboat", "Motorboat")
  end

  def self.non_sailors

  end
  
end
