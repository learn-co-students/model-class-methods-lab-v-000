class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    self.joins(:classifications).where("classifications.name = 'Catamaran'")
  end

  def self.sailors
    self.joins(:classifications).where("classifications.name = 'Sailboat'").uniq
  end

  def self.motors
    self.joins(:classifications).where("classifications.name = 'Motorboat'").uniq
  end

  def self.talented_seafarers
    ids = self.sailors.ids & self.motors.ids
    self.sailors.where(id: ids)
  end

  def self.non_sailors
    ids = self.all.ids - self.sailors.ids
    self.all.where(id: ids)
  end
end
