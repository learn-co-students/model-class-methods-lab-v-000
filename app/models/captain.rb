class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    self.joins(:classifications).where(:'classifications.name' => 'Catamaran').distinct
  end

  def self.sailors
    self.joins(:classifications).where(:'classifications.name' => 'Sailboat').distinct
  end

  def self.motorboat_operators
    self.joins(:classifications).where(:'classifications.name' => 'Motorboat').distinct
  end

  def self.talented_seafarers
    self.motorboat_operators.where(id: self.sailors.pluck(:id))
  end

  def self.non_sailors
    self.where.not(id: self.sailors.pluck(:id))
  end
end
