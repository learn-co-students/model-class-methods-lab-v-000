class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    includes(:classifications).where(classifications: { name: 'Catamaran' })
    .references(:classifications)
  end

  def self.sailors
    includes(:classifications).where(classifications: { name: 'Sailboat' })
    .references(:classifications).distinct
  end

  def self.motorboaters
    includes(:classifications)
    .where(classifications: { name: 'Motorboat' }).distinct
  end

  def self.talented_seamen
    sailors = self.sailors.pluck(:id)
    motorboaters = self.motorboaters.pluck(:id)
    where(id: sailors & motorboaters)
  end

  def self.non_sailors
    sailors = self.sailors.pluck(:id)
    where.not(id: sailors)
  end
end
