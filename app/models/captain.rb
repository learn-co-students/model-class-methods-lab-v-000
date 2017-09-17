class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: [:boat_classifications, :classifications]).
      where(classifications: {name: "Catamaran"}).uniq
  end

  def self.sailors
    self.joins(boats: [:boat_classifications, :classifications]).
      where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seamen
    talented_arr = self.joins(boats: [:boat_classifications, :classifications]).
      where(classifications: {name: "Sailboat"}).
      uniq & self.joins(boats: [:boat_classifications, :classifications]).
      where(classifications: {name: "Motorboat"}).uniq
    # compares self id with an array of talented_arr ids
    self.where(id: talented_arr.map(&:id))
  end

  def self.non_sailors
    self.where.not(id: self.sailors.pluck(:id))
  end

end
