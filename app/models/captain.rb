require 'pry'
class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  includes(boats: :classifications).where("classifications.name = ?", "Catamaran").
references(:classifications)
  end

  def self.sailors

    includes(boats: :classifications).where("classifications.name = ?", "Sailboat").
  references(:classifications).distinct
  end

  def self.motorboaters
    includes(boats: :classifications).where("classifications.name = ?", "Motorboat").
  references(:classifications).distinct
  end

  def self.talented_seafarers

    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id)).distinct
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
