class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.joins(boats: :classifications).where(classifications: { name: "Catamaran" })
  end

  def self.sailors
    Captain.joins(boats: :classifications).where(classifications: { name: "Sailboat" }).uniq
  end

  def self.talented_seafarers
    Captain.joins(boats: :classifications).where(classifications: { name: "Motorboat", name: "Sailboat" }).uniq
  end

  def self.non_sailors
    all = Captain.select(:name)
    sailors = Captain.joins(boats: :classifications).where(classifications: { name: "Sailboat" }).uniq
    answer = all - sailors
    binding.pry
  end

end
