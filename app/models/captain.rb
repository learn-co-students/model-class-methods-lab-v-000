class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #binding.pry
    self.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
    #Boat.joins(:classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    self.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboats
    self.includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seafarers
    #binding.pry
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboats.pluck(:id))
    #self.includes(boats: :classifications).where(classifications: {name: "Sailboat" & "Motorboat"}).uniq
    #self.includes(boats: :classifications).where('name = ? AND name = ?', "Sailboat" AND "Motorboat").uniq
  end

  def self.non_sailors
    #binding.pry
    where.not("id IN (?)", self.sailors.pluck(:id)).uniq
  end

end
