class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where('classifications.name == ?', 'Catamaran').uniq
  end

  def self.sailors
    joins(boats: :classifications).where('classifications.name == ?', 'Sailboat').uniq
  end

  def self.talented_seamen
    motor_guys = joins(boats: :classifications).where('classifications.name == ?', 'Motorboat').uniq
    sailboat_guys = joins(boats: :classifications).where('classifications.name == ?', 'Sailboat').uniq
    motor_guys & sailboat_guys
  end

  def self.non_sailors
    no_sailboat_guys = joins(boats: :classifications).where.not('classifications.name == ?', 'Sailboat').uniq
    sailboat_guys = joins(boats: :classifications).where('classifications.name == ?', 'Sailboat').uniq
    no_sailboat_guys - sailboat_guys
  end

end
