class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where(classifications: { name: "Catamaran" })
  end

  def self.sailors
    joins(boats: :classifications).where(classifications: { name: "Sailboat" }).uniq
  end

  def self.motorboats
    joins(boats: :classifications).where(classifications: { name: "Motorboat" }).uniq
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboats.pluck(:id))
  end

  def self.all_boaters
    all
  end

  def self.non_sailors
    where("id IN (?)", self.all_boaters.pluck(:id) - self.sailors.pluck(:id))
  end

end
