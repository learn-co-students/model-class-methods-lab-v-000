class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    joins(:boats).joins(:classifications).where(classifications: { name: 'Catamaran' }).distinct
  end

  def self.sailors
    joins(:boats).joins(:classifications).where(classifications: { name: 'Sailboat' }).distinct
  end

  def self.talented_seafarers
    joins(:boats).joins(:classifications).where(classifications: { name: 'Sailboat' }).where(classifications: { name: 'Motorboat' })
  end
end
