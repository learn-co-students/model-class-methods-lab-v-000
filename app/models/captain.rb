class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: { name: "Catamaran"}).uniq
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: { name: "Sailboat"}).uniq
  end

  def self.motors
      includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seamen
    where("id IN (?)", self.sailors.pluck(:id) & self.motors.pluck(:id))
  end

  def self.non_sailors
    where(id: self.all - self.sailors)
  end
end
