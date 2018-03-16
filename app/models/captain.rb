class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.includes(boats: :classifications).where(classifications: {name: "Catamaran"}).distinct
  end

  def self.sailors
    Captain.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.talented_seamen
    # self.sailors & self.motor_boat_seamen
    where("id IN (?)", self.sailors.pluck(:id) & self.motor_boat_seamen.pluck(:id))
  end

  def self.non_sailors
    self.where.not("id IN (?)", self.sailors.pluck(:id))
    # Captain.includes(boats: :classifications).where.not(classifications: {name: "Sailboat"}).distinct
  end

  def self.motor_boat_seamen
    Captain.includes(boats: :classifications).where(classifications: {name: "Motorboat"}).distinct
  end

end
