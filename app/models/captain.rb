class Captain < ActiveRecord::Base
  has_many :boats

  def catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def talented_seafarers
    where("id IN (?)", self.sailers.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end


end
