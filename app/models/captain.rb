class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats
  def self.catamaran_operators
    self.joins(:classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    self.joins(:classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seafarers
    q = self.joins(:classifications).where(classifications: {name: "Motorboat"}).uniq
    l = self.sailors
    where("id IN (?)", q.ids & l.ids).uniq
  end

  def self.non_sailors
    l = self.sailors
    where.not("id IN (?)", l.ids).uniq
  end
end
