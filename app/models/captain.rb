class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(:boats).merge(Boat.catamarans)
  end

  def self.sailors
    joins(:boats).merge(Boat.sailboats).uniq
  end

  def self.motorboaters
    joins(:boats).merge(Boat.motorboats).uniq
  end

  def self.talented_seafarers
      where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
      # sail = joins(:boats).merge(Boat.sailboats).uniq
      # motor =  joins(:boats).merge(Boat.motorboats).uniq
      # sail & motor
  end

  def self.non_sailors
    # self.all - self.sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
