class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # select t2.name from boats
    # left outer join boat_classifications t0 on boats.id = t0.boat_id
    # left outer join classifications t1 on t0.classification_id = t1.id
    # left outer join captains t2 on boats.captain_id = t2.id
    # where t1.name = 'Catamaran
    joins(boats: :classifications).where('classifications.name = "Catamaran"')
  end

  def self.sailors
    joins(boats: :classifications).where(classifications: {name: "Sailboat"}).group(:name)
  end

  def self.motorboat_operators
    joins(boats: :classifications).where(classifications: {name: "Motorboat"}) # .group(:name)
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    where("id NOT IN (?)", self.sailors.pluck(:id)) # .group(:name).order(:id)
  end
end
