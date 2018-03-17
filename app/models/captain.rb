class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where('classifications.name == ?', 'Catamaran').uniq
  end

  def self.sailors
    joins(boats: :classifications).where('classifications.name == ?', 'Sailboat').uniq
  end

  def self.motors
    joins(boats: :classifications).where('classifications.name == ?', 'Motorboat').uniq
  end

  def self.talented_seamen
    talent_ids = sailors.pluck(:id) & motors.pluck(:id)
    where('id == ? or id == ?', talent_ids[0], talent_ids[1])
  end

  def self.non_sailors
    non_sail_ids = joins(boats: :classifications).where.not('classifications.name == ?', 'Sailboat').uniq.pluck(:id) - sailors.pluck(:id)
    where('id == ? or id == ? or id == ?', non_sail_ids[0], non_sail_ids[1], non_sail_ids[2])
  end

end
