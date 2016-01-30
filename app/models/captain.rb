class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.sailboaters
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).pluck(:id)
  end

  def self.motorboaters
    includes(boats: :classifications).where(classifications: {name: "Motorboat"}).pluck(:id)
  end

  def self.sail_or_motor
    includes(boats: :classifications).where(id: self.motorboaters, classifications: {name: "Sailboat"}).pluck(:id)
  end

  def self.talented_seamen
    where(id: self.sail_or_motor)
  end

  def self.non_sailors
    where.not(id: self.sailboaters)
  end

end
