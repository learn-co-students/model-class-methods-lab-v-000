class Captain < ActiveRecord::Base
  has_many :boats

  extend ArelTables

  def self.catamaran_operators
    self.joins(boats: :classifications).where(classifications_arel[:name].eq("Catamaran")).group(captains_arel[:name])
  end
  
  def self.sailors
    self.joins(boats: :classifications).where(classifications_arel[:name].eq("Sailboat")).group(captains_arel[:name])
  end

  def self.talented_seamen
    intersection = self.joins(boats: :classifications).where(classifications_arel[:name].eq("Motorboat")).group("captains.name").intersect(self.joins(boats: :classifications).where(classifications_arel[:name].eq("Sailboat")).group("captains.name"))

    self.from(self.arel_table.create_table_alias(intersection,:captains))
  end

  def self.non_sailors
    self.where.not(name: self.sailors.pluck(:name)).group("captains.name").order(id: :asc)
  end
  
end
