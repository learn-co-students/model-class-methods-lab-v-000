class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.includes(boats: :classifications).where(classifications: {name: 'Catamaran'})
  end

  def self.sailors
    Captain.includes(boats: :classifications).where(classifications: {name: 'Sailboat'}).uniq
  end

  def self.motorboat_operators
    Captain.includes(boats: :classifications).where(classifications: {name: 'Motorboat'}).uniq
  end


  def self.talented_seafarers
    Captain.where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id) )
    # Captain.includes(boats: :classifications).where(self.motorboat_operators && self.sailors)
    # Captain.includes(boats: :classifications).where(classifications: {name: 'Motorboat'}).where(classifications: {name: 'Sailboat'}).uniq
# Model.where(:column => ["value", "other_value"]

  end

  def self.non_sailors
    Captain.where.not("id IN (?)",self.sailors.pluck(:id))
    # Captain.includes(boats: :classifications).where(classifications: {name: !'Sailboat'})
  end

end
