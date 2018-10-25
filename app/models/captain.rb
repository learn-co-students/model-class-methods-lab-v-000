class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where(Classification.arel_table[:name].eq("Catamaran"))
  end

  def self.sailors
    joins(boats: :classifications).where(Classification.arel_table[:name].eq("Sailboat")).uniq
  end

  def self.talented_seafarers
    # binding.pry
    where(id: self.sailors & self.motorboats)
  end

  def self.non_sailors
    where(id: all - self.sailors)
  end

  def self.motorboats
    joins(boats: :classifications).where(Classification.arel_table[:name].eq("Motorboat"))
  end
end 
