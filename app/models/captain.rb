class Captain < ActiveRecord::Base
  has_many :boats

  # def self.catamaran_operators
  #   includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  # end
  #
  # def self.sailors
  #   includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  # end
  #
  def self.catamaran_operators
    Captain.joins(boats: [{boat_classifications: :classification} ]).where('classifications.name' => "Catamaran")
  end

  def self.sailors
    Captain.joins(boats: [{boat_classifications: :classification} ]).where('classifications.name' => "Sailboat").uniq
  end

  def self.motors
    Captain.joins(boats: [{boat_classifications: :classification} ]).where('classifications.name' => "Motorboat").uniq
  end

  def self.talented_seamen
    where("id IN (?)", self.sailors & self.motors)
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
