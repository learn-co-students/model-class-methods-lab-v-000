class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(:boats).joins("INNER JOIN boat_classifications ON boats.id = boat_classifications.boat_id").joins("INNER JOIN classifications ON boat_classifications.classification_id = classifications.id").where("classifications.name" => "Catamaran")
  end

  def self.sailors
    joins(:boats).joins("INNER JOIN boat_classifications ON boats.id = boat_classifications.boat_id").joins("INNER JOIN classifications ON boat_classifications.classification_id = classifications.id").where("classifications.name" => "Sailboat").distinct
  end

  def self.motorboaters
    joins(:boats).joins("INNER JOIN boat_classifications ON boats.id = boat_classifications.boat_id").joins("INNER JOIN classifications ON boat_classifications.classification_id = classifications.id").where("classifications.name" => "Motorboat").distinct
  end

  def self.talented_seamen
    where(id: self.motorboaters.pluck(:id) & self.sailors.pluck(:id))
  end

  def self.non_sailors
    where.not(id: self.sailors.pluck(:id))
  end
end
