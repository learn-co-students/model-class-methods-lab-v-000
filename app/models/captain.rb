class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
     all.includes(boats: :classifications).where(classifications: {name: "Catamaran"}).uniq
  end

  def self.sailors
    all.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    all.includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seafarers
    sailors = self.sailors.pluck(:id)
    motorboaters = self.motorboaters.pluck(:id)

    all.where("id IN (?)", sailors & motorboaters)
  end

  def self.non_sailors
    where.not("id IN (?)", sailors.pluck(:id))
  end


end
