class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seafarers
    captains = []
    sailors.each {|sailor| captains << sailor.id}
    includes(boats: :classifications).where({classifications: {name: "Motorboat"}, captains: {id: captains}})
  end

  def self.non_sailors
    where.not("id IN (?)", sailors.pluck(:id))
  end
end
