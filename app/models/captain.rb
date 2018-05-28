class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where("classifications.name = 'Catamaran'").distinct
  end

  def self.sailors
    joins(boats: :classifications).where("classifications.name = 'Sailboat'").distinct
  end

  def self.talented_seafarers
    motorboatists = Captain.joins(boats: :classifications).where("classifications.name = 'Motorboat'").distinct
    Captain.sailors.where(id: motorboatists.ids)
  end

  def self.non_sailors
    where.not(id: Captain.sailors.ids)
  end
end
