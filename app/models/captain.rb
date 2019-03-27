class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    includes(:classifications).where(classifications: {name: 'Catamaran'})
  end

  def self.sailors
    includes(:classifications).where(classifications: {name: 'Sailboat'}).distinct
  end

  def self.motorboaters
    includes(:classifications).where(classifications: {name: 'Motorboat'}).distinct
  end

  def self.talented_seafarers
    where("id IN (?)", sailors.pluck(:id) & motorboaters.pluck(:id))
    # includes(:classifications).where("classifications = ?, ?", "Sailboat", "Motorboat")
    # includes(:classifications).where(classifications: {name: 'Sailboat'} & {name: 'Motorboat'})
  end

  def self.non_sailors
    where("id NOT IN (?)", sailors.pluck(:id))
    # includes(:classifications).where(classifications: {name: 'Sailboat'}).distinct.unscope(:where)
  end
end
