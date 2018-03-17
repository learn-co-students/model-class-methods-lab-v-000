class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"}).uniq
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seamen
    motorboats = includes(boats: :classifications).where(classifications: {name: "Motorboat"})
    ids = self.sailors.pluck(:id) & motorboats.pluck(:id)
    where("id IN (?)", ids).uniq
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
