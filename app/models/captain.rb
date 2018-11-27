class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    a = Boat.by_cat('Catamaran').collect{|b| b.name}
    self.joins(:boats).where(boats:{name: a}).distinct
  end

  def self.sailors
    a = Boat.sailboats.collect{|b| b.name}
    # binding.pry
    self.joins(:boats).where(boats:{name: a}).distinct
  end

  def self.motorboaters
    a = Boat.by_cat('Motorboat').collect{|b| b.name}
    # binding.pry
    self.joins(:boats).where(boats:{name: a}).distinct
  end

  def self.talented_seafarers
    # binding.pry
    # a = Boat.by_cat('Sailboat').collect{|b| b.name}
    # c = Boat.by_cat('Motorboat').collect{|b| b.name}
    # self.joins(:boats).where(boats:{name: a}).where(boats:{name:c})
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))

  end

  def self.non_sailors
    # a = Boat.sailboats.collect{|b| b.name}
    # self.joins(:boats).where.not(boats:{name: a}).distinct
    where("id not IN (?)", self.sailors.pluck(:id))
  end
end
