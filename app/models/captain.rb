class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.all.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    self.all.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    self.all.includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seamen
    self.all.where("id IN (?)", self.sailors & self.motorboaters)
  end

  def self.non_sailors
    self.all.where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
