class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    self.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboat
    self.includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seafarers
    self.where("id IN (?)", sailors.pluck(:id) & motorboat.pluck(:id))
  end

  def self.non_sailors
    self.where.not("id IN (?)", sailors.pluck(:id) || motorboat.pluck(:id))
  end
end
