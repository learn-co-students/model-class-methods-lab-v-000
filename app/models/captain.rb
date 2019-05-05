class Captain < ActiveRecord::Base
  has_many :boats

# call the boats table then the column classifications (because of the has_many through association) then call the classifications table and name column
  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {:name => "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {:name => "Sailboat"}).distinct
  end

  def self.motorboats
    includes(boats: :classifications).where(classifications: {:name => "Motorboat"})
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboats.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
