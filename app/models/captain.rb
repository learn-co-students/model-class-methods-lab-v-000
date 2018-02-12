class Captain < ActiveRecord::Base
  has_many :boats

#  def self.sailboats
#    Boat.joins(:classifications).where(classifications: {name: "Sailboat"})
#  end

  def self.catamaran_operators
    Captain.joins(boats: :classifications).where(classifications: {name: "Catamaran"}).group("captains.name")
  end

  def self.sailors
    Captain.joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    Captain.joins(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seamen
    #Captain.joins(boats: :classifications).where("classifications.name = ? OR classifications.name = ?", "Motorboat", "Sailboat").group("classifications.name").order("captains.name asc")
    where("id IN (?) AND id IN (?)", Captain.sailors.pluck(:id), Captain.motorboaters.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", Captain.sailors.pluck(:id))
  end
end
