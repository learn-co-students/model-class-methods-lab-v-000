class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: { name: "Catamaran" })
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: { name: "Sailboat" }).distinct
  end

  def self.talented_seafarers
    sailboat = includes(boats: :classifications).where(classifications: { name: "Sailboat" }).ids
    motorboat = includes(boats: :classifications).where(classifications: { name: "Motorboat" }).ids
    ids = sailboat & motorboat
    where('id in (?)', ids)
  end

  def self.non_sailors
    ids = includes(boats: :classifications).where(classifications: { name: "Sailboat" }).ids
    where.not('id in (?)', ids)
  end

end
