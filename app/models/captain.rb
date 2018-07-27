class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where("classifications.name = 'Catamaran'")
  end

  def self.sailors
    joins(boats: :classifications).where("classifications.name = 'Sailboat'").distinct
  end

  def self.motorboatists
    joins(boats: :classifications).where("classifications.name = 'Motorboat'").distinct
  end

  def self.non_sailors
    self.where.not(id: self.sailors.pluck(:id))
  end

  def self.talented_seafarers
    # select all captains that have a boat with classification "Sailboat" AND classification "Motorboat"
    # binding.pry
    self.where(id: self.sailors.pluck(:id) & self.motorboatists.pluck(:id))
  end

end
