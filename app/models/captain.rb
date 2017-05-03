class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # Boat.joins(:classifications).includes(:captain).where(classifications: {name: "Catamaran"}).map {|boat| boat.captain}
    Captain.joins(boats: :classifications).where(classifications: {name: "Catamaran"}).uniq
  end

  def self.sailors
    Captain.joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    Captain.joins(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seamen
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
    # self.select {|captain| !captain.name.match(/(Captain)/)}
  end
end
