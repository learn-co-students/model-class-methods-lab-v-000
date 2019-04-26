class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.talented_seafarers
    sailer_ids = self.sailors.map do |sailor|
      sailor.id
    end
    includes(boats: :classifications).where({classifications: {name: "Motorboat"}, captains: {id: sailer_ids }})
  end

  def self.non_sailors
    where.not("id IN (?)", sailors.pluck(:id))
  end
end
