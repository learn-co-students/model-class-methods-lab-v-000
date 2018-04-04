class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    joins(:classifications).where({ classifications: {name: 'Catamaran'} })
  end

  def self.sailors
    joins(:classifications).where({ classifications: {name: 'Sailboat'} }).distinct
  end

  def self.talented_seafarers
    joins(:classifications).where({ classifications: {name: 'Sailboat'}}).where({ classifications: {name: 'Motorboat'} })
  end

  def self.non_sailors
    joins(:classifications).where.not({ classifications: {name: 'Sailboat'} })
  end
end
