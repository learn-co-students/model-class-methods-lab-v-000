class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    self.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seafarers
    motorboaters = self.joins(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
    self.where("id IN (?)", self.sailors.pluck(:id) & motorboaters.pluck(:id))
  end

  def self.non_sailors
    self.where.not(id: sailors.pluck(:captain_id))
  end

end
