class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"}).uniq
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboater
    includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seafarers
    where("name in (?)", sailors.pluck(:name) & motorboater.pluck(:name))
  end

  def self.non_sailors
    where.not("name in (?)", sailors.pluck(:name))
  end
end
