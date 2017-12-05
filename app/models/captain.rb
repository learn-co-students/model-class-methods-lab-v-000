class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"}).distinct
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.captain_type(type_of_ship)
    includes(boats: :classifications).where(classifications: {name: type_of_ship}).distinct
  end

  def self.talented_seamen
    where("id IN (?)", self.captain_type("Sailboat").pluck(:id) & self.captain_type("Motorboat").pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
