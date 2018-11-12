class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats
  def self.catamaran_operators
    self.joins(:classifications).where(:classifications => {name: "Catamaran"})
  end

  def self.sailors
    self.joins(:classifications).where(:classifications => {name: "Sailboat"}).uniq
  end

  def self.motorboats
    self.joins(:classifications).where(:classifications => {name: "Motorboat"}).uniq
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboats.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
